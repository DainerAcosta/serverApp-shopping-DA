import { Request, Response } from 'express';
import { queryHandler } from '../database/db';

class ProductsController {

    public async getAll(req: Request, res: Response): Promise<any> {
        try {
            const rows = await queryHandler(
                `SELECT * FROM st_product`
            );
            res.status(200).json(rows);
        } catch (error) {
            throw error;
        }
    }

}

export const productsController = new ProductsController();