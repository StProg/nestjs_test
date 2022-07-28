import { Module } from '@nestjs/common';
import { CarService } from './car.service';
import { CarController } from './car.controller';
import { DbModule } from '../db-module.module';

@Module({
  controllers: [CarController],
  providers: [CarService],
  imports: [DbModule]
})
export class CarModule {}
