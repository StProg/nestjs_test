import { Injectable, Inject } from '@nestjs/common';
import { PG_CONNECTION } from '../db-module.module';

@Injectable()
export class BooService {
    constructor(@Inject(PG_CONNECTION) private conn: any) { }


//     async findAll() {

//         const res = await this.conn.query('SELECT * FROM users');
//         return res.rows;

//     }
    
    async doBook(id: number, from: string, to: string) {
        const res = await this.conn.query(`
            select test_func_book(${id},'${from}','${to}') as res
        `);
        return res.rows[0].res;
    }
    findOne(id: number) {
        return `This action returns a #${id} boo`;
    }


}
