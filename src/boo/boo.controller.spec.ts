import { Test, TestingModule } from '@nestjs/testing';
import { BooController } from './boo.controller';
import { BooService } from './boo.service';

describe('BooController', () => {
  let controller: BooController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [BooController],
      providers: [BooService],
    }).compile();

    controller = module.get<BooController>(BooController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
