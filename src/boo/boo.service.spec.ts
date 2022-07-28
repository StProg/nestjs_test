import { Test, TestingModule } from '@nestjs/testing';
import { BooService } from './boo.service';

describe('BooService', () => {
  let service: BooService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [BooService],
    }).compile();

    service = module.get<BooService>(BooService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
