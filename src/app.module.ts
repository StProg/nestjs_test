import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DbModule } from './db-module.module';
import { BooModule } from './boo/boo.module';
import { CarModule } from './car/car.module';
 
@Module({
  imports: [DbModule, BooModule, CarModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
