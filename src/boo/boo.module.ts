import { Module } from '@nestjs/common';
import { BooService } from './boo.service';
import { BooController } from './boo.controller';
import { DbModule } from '../db-module.module';

@Module({
  controllers: [BooController],
  providers: [BooService],
  imports: [DbModule]
})
export class BooModule {}
