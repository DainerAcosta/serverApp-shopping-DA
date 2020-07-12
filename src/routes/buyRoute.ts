import { Router } from 'express';

// controllers
import { buyController } from '../controllers/buyController';

class SalesRoute {

    public router: Router = Router();

    constructor() {
        this.config();
    }

    config(): void {
        this.router.post('/user', buyController.getOneUser);
        this.router.post('/', buyController.createUserAndBuy);
    }
}

const salesRoute = new SalesRoute();
export default salesRoute.router;