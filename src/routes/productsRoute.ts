import { Router } from 'express';

// Controllers
import { productsController } from '../controllers/productsController';

class ProductsRouter {
    
    public router: Router = Router();

    constructor() {
        this.config();
    }

    config(): void {
        this.router.get('/', productsController.getAll);
    }
}

const productsRoutes = new ProductsRouter();
export default productsRoutes.router;