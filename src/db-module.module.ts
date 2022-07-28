import { Module } from "@nestjs/common";
import { Pool } from 'pg';
 
export const PG_CONNECTION = 'PG_CONNECTION';

const dbProvider = {
  provide: PG_CONNECTION,
  useValue: new Pool({
    user: "root",
    host: "localhost",
    database: "test",
    password: "dfktyrb12",
    port: 5432,
  }),
};

@Module({
  providers: [dbProvider],
  exports: [dbProvider],
})
export class DbModule {}