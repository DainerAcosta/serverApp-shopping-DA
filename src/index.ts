import express, { Application } from 'express';
import morgan from 'morgan';
import cors from 'cors';
require('dotenv').config();

// Routes
import productsRoute from './routes/productsRoute';
import buyRoute from './routes/buyRoute';

class Server {

    public app: Application;

    constructor() {
        this.app = express();
        this.config();
        this.routes();
    }

    config(): void {
        this.app.set('port', process.env.PORT || 3001);
        this.app.use(morgan('dev'));
        this.app.use(cors());
        this.app.use(express.json());
        this.app.use(express.urlencoded({extended: false}));
    }

    routes(): void {
        /* this.app.use('/', ); */
        this.app.use('/products', productsRoute);
        this.app.use('/buy', buyRoute);
    }

    start(): void {
        this.app.listen(this.app.get('port'), () => {
            console.log(`Serve on port http://localhost:${this.app.get('port')}`);
        })
    }
}

const server = new Server();
server.start();