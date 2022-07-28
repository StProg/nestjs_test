import { Injectable, Inject } from '@nestjs/common';
import { PG_CONNECTION } from './db-module.module';

@Injectable()
export class AppService {
    constructor(@Inject(PG_CONNECTION) private conn: any) { }
//    getHello():string {
//        return 'Hello World!';
//    };
    async getTest() {
        const res = await this.conn.query('SELECT * FROM users');
        return res.rows;
    }
}

