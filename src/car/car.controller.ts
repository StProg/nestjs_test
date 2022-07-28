import { Controller, Get, Param, Query } from '@nestjs/common';
import { CarService } from './car.service';

@Controller('car')
export class CarController {
    constructor(private readonly carService: CarService) { }

    @Get('/isavailable')  //http://localhost:3000/car/isavailable?id=1&from=2022-01-01&to=2022-01-12
    async isAvailable(@Query() query) {
        if (query.id && query.from && query.to) {
            //Добавить валидацию параметров регулярным!
            return this.carService.isAvailable(query.id, query.from, query.to);
        } else {
            return '0';
        }
    }

    @Get('/getcost')  //http://localhost:3000/car/getcost?id=1&from=2022-01-01&to=2022-01-12
    async getCost(@Query() query) {
        if (query.id && query.from && query.to) {
            //Добавить валидацию параметров регулярным!
            return this.carService.getCost(query.id, query.from, query.to);
        } else {
            return '0';
        }
    }
    
    @Get('/all')
    findAll() {
        return this.carService.findAll();
    }

    @Get(':id')
    findOne(@Param('id') id: string) {
        return this.carService.findOne(+id);
    }

}
