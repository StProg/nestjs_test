import { Injectable, Inject } from '@nestjs/common';
import { PG_CONNECTION } from '../db-module.module';

@Injectable()
export class CarService {
    constructor(@Inject(PG_CONNECTION) private conn: any) { }

    async isAvailable(id: number, from: string, to: string) {
        const res = await this.conn.query(`
            select test_func_isavailable(${id},'${from}','${to}') as is_available
        `);
        return res.rows[0].is_available;
    }

    async getCost(id: number, from: string, to: string) {
        const res = await this.conn.query(`
            select test_func_calccost(${id},'${from}','${to}') as cost
        `);
        return res.rows[0].cost;
    }

    async findAll() {
        const res = await this.conn.query('SELECT * FROM test_cars');
        return res.rows;

    }

    findOne(id: number) {
        return `This action returns a #${id} car`;
    }

}
