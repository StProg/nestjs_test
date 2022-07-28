import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { BooService } from './boo.service';

@Controller('boo')
export class BooController {
  constructor(private readonly booService: BooService) {}


  @Get()
  findAll() {
    return this.booService.findAll();
  }

  @Get('/dobook') //http://localhost:3000/boo/dobook?id=1&from=2022-07-11&to=2022-07-20
    async doBook(@Query() query) {
        if (query.id && query.from && query.to) {
            //Добавить валидацию параметров регулярным!
            return this.booService.doBook(query.id, query.from, query.to);
        } else {
            return '0';
        }
    }
  
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.booService.findOne(+id);
  }

}
