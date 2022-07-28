-- Table: public.test_car_models

-- DROP TABLE IF EXISTS public.test_car_models;

CREATE TABLE IF NOT EXISTS public.test_car_models
(
    id numeric NOT NULL,
    name text COLLATE pg_catalog."default",
    CONSTRAINT test_car_models_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.test_car_models
    OWNER to postgres;

COMMENT ON TABLE public.test_car_models
    IS 'Модели автомобилей';

CREATE TABLE IF NOT EXISTS public.test_cars
(
    id numeric NOT NULL,
    reg_num text COLLATE pg_catalog."default" NOT NULL,
    model numeric,
    tarif numeric DEFAULT 0,
    CONSTRAINT test_cars_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.test_cars
    OWNER to postgres;

COMMENT ON TABLE public.test_cars
    IS 'Автомобили';

-- Table: public.test_boos

-- DROP TABLE IF EXISTS public.test_boos;

CREATE TABLE IF NOT EXISTS public.test_boos
(
    id numeric NOT NULL,
    car numeric NOT NULL,
    "from" timestamp without time zone NOT NULL,
    "to" timestamp without time zone NOT NULL,
    cost numeric,
    days numeric,
    CONSTRAINT boos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.test_boos
    OWNER to postgres;

COMMENT ON TABLE public.test_boos
    IS 'Бронирования';

-- FUNCTION: public.test_func_calccost(integer, text, text)

-- DROP FUNCTION IF EXISTS public.test_func_calccost(integer, text, text);

CREATE OR REPLACE FUNCTION public.test_func_calccost(
	car integer,
	"from" text,
	"to" text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
    declare "cost" integer;
	declare v_tarif integer;
	declare days integer;
BEGIN
	"cost" = 0;
	select tarif into v_tarif from test_cars where id = $1;
	if v_tarif < 1 then return 0; end if;
	select date($3) - date($2) + 1 into days;
	if days < 1 then return 0; end if;
	
	select least(days,4)*v_tarif into "cost"; --100%
	
	if days > 4 then --95%
		days = days - 4;
		select "cost" + least(days,5)*v_tarif*.95 into "cost";
				if days > 5 then --90%
				days = days - 5;
				select "cost" + least(days,8)*v_tarif*.90 into "cost";
					if days > 8 then --85%
						days = days - 8;
						select "cost" + least(days,12)*v_tarif*.85 into "cost"; 
						-- По 29-й день. Что делать с 30-м в задании не указано
					end if;			
			end if;	
	end if;
	RETURN "cost" ;
END
$BODY$;

ALTER FUNCTION public.test_func_calccost(integer, text, text)
    OWNER TO postgres;


-- FUNCTION: public.test_func_isavailable(integer, text, text)

-- DROP FUNCTION IF EXISTS public.test_func_isavailable(integer, text, text);

CREATE OR REPLACE FUNCTION public.test_func_isavailable(
	car integer,
	"from" text,
	"to" text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare is_available integer;
BEGIN
	select 1 - least(1,count(1)) into is_available 
	from test_boos b
	where b.car = $1
	  and (
		  (b.from - interval '3 day' between date($2) and date($3))
	   	   or (b.to + interval '3 day' between date($2) and date($3))
		  )
	   or (select extract(isodow from date($2))) > 5
	   or (select extract(isodow from date($3))) > 5
	   or date($3) - date($2) > 30
	   or not exists (select 1 from test_cars where id = $1);
   return  is_available;
END
$BODY$;

ALTER FUNCTION public.test_func_isavailable(integer, text, text)
    OWNER TO postgres;


-- FUNCTION: public.test_func_book(integer, text, text)

-- DROP FUNCTION IF EXISTS public.test_func_book(integer, text, text);

CREATE OR REPLACE FUNCTION public.test_func_book(
	car integer,
	"from" text,
	"to" text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
    declare "cost" integer;
	declare res integer;
	declare v_id integer;
BEGIN
	res = 0;
	
	if (select count(1) from test_boos) <1
		then v_id = 1; 
	else 
		v_id =(select max("id") from test_boos)+1;
	end if;
	
	select test_func_calccost($1,$2,$3) into "cost";
	if "cost" > 0 and test_func_isavailable($1,$2,$3) > 0 then
	  -- Do book
	  insert into test_boos ("id",car,"from","to","cost",days)
	  values (v_id,
			 $1,
			 date($2),
			 date($3),
			 "cost",
			 date($3)-date($2)+1);
	  end if;
	  res = 1;
	RETURN res ;
END
$BODY$;

ALTER FUNCTION public.test_func_book(integer, text, text)
    OWNER TO postgres;




INSERT INTO public.test_car_models (id, name) VALUES (1, 'Lexus');
INSERT INTO public.test_car_models (id, name) VALUES (2, 'Zaporozec');
INSERT INTO public.test_car_models (id, name) VALUES (3, 'Lada');
INSERT INTO public.test_car_models (id, name) VALUES (4, 'Renault');
INSERT INTO public.test_car_models (id, name) VALUES (5, 'УАЗ');

INSERT INTO public.test_cars (id, reg_num, model, tarif) VALUES (1, 'A111AA', 1, 1000);
INSERT INTO public.test_cars (id, reg_num, model, tarif) VALUES (2, 'B222BB', 2, 1000);
INSERT INTO public.test_cars (id, reg_num, model, tarif) VALUES (3, 'C333CC', 3, 1000);
INSERT INTO public.test_cars (id, reg_num, model, tarif) VALUES (4, 'E444EE', 4, 1000);
INSERT INTO public.test_cars (id, reg_num, model, tarif) VALUES (5, 'H555HH', 5, 1000);

INSERT INTO public.test_boos (id, car, "from", "to", cost, days) VALUES (1, 1, '2022-07-11 00:00:00', '2022-07-20 00:00:00', 9650, 10);

