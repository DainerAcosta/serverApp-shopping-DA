import { Request, Response } from "express";
import { queryHandler } from "../database/db";

// Obtiene un usuario
class BuyController {
  public async getOneUser(req: Request, res: Response): Promise<any> {
    try {
      const { payload } = req.body;
      const row = await queryHandler(`SELECT * FROM us_user WHERE email=?`, [
        payload,
      ]);
      if (row[0]) {
        res.status(200).json(row);
      } else {
        res.status(200).json({ msn: "sorry unregistered user" });
      }
    } catch (error) {
      throw error;
    }
  }

  // Crea un usuario y si existe lo verifica y crea la compra asociada a ese usuario
  public async createUserAndBuy(req: Request, res: Response): Promise<any> {
    try {
      const {
        f_id,
        f_full_name,
        f_dni,
        f_address,
        f_phone_number,
        f_email,
      } = req.body.payload.user;
      const { f_products, f_price_total } = req.body.payload.buy;
      const row = await queryHandler(`SELECT * FROM us_user WHERE email=?`, [
        f_email,
      ]);
      // Verifica si el usuario existe
      if (row[0]) {
        let verification_product: boolean = true;
        let verification_price_total: number = 0;
        const { id, full_name, dni, address, phone_number, email } = row[0];
        // Verifica que el usuario que esta comprando, tenga la misma informacion en la db --por seguaridad--
        if (
          id === f_id &&
          full_name === f_full_name &&
          dni === f_dni &&
          address === f_address &&
          phone_number === f_phone_number &&
          email === f_email
        ) {
          //Verifica que los productos que envia el usuario, tengan la misma informacion en la db --por seguridad-- 
          for (const product of f_products) {
            let row = await queryHandler(
              `SELECT * FROM st_product WHERE id=? AND name_product=? AND price=?`, 
              [product.id, product.name_product, product.price]);
            if (!row[0]) {
              verification_product = false;
              res.status(200).json({ msn: "Oops, unexpected error #1" });
              return
            }
            verification_price_total += (row[0].price * product.quantity);
          }
          // Inserta la compra y los detalles de la compra en sus respectivas tablas
          if (verification_product && verification_price_total === f_price_total) {
            const {
              insertId,
            } = await queryHandler(
              `INSERT INTO st_buy (id_user, price_total) VALUES (?, ?)`,
              [f_id, verification_price_total]
            );
            for (const product of f_products) {
              await queryHandler(
                `INSERT INTO st_detail (id_buy, id_product, unit_price, quantity) 
                VALUES (?, ?, ?, ?)`,
                [insertId, product.id, product.price, product.quantity]
              );
            }
            res.status(200).json({ msn: "successful purchase #2" });
          }
        } else {
          res.status(200).json({ msn: "Oops, unexpected error #3" });
          return
        }
      } else {
        let verification_product: boolean = true;
        let verification_price_total: number = 0;
        // Crea el nuevo usuario
        const user = await queryHandler(
          `INSERT INTO us_user (
            full_name,
            dni,
            address,
            phone_number,
            email
          )
          VALUES (?, ?, ?, ?, ?)`,
          [f_full_name, f_dni, f_address, f_phone_number, f_email]
        );

        //Verifica que los productos que envia el usuario en la compra sean veridicos --por seguridad-- 
        for (const product of f_products) {
          let row = await queryHandler(
            `SELECT * FROM st_product WHERE id=? AND name_product=? AND price=?`, 
            [product.id, product.name_product, product.price]);
          if (!row[0]) {
            verification_product = false;
            res.status(200).json({ msn: "Oops, unexpected error" });
            return
          }
          verification_price_total += (row[0].price * product.quantity);
        }
        // Inserta la compra y los detalles de la compra en sus respectivas tablas
        if (verification_product && verification_price_total === f_price_total) {
          const {
            insertId,
          } = await queryHandler(
            `INSERT INTO st_buy (id_user, price_total) VALUES (?, ?)`,
            [user.insertId, verification_price_total]
          );
          for (const product of f_products) {
            await queryHandler(
              `INSERT INTO st_detail (id_buy, id_product, unit_price, quantity) 
              VALUES (?, ?, ?, ?)`,
              [insertId, product.id, product.price, product.quantity]
            );
          }
          res.status(200).json({ msn: "successful purchase" });
        }
      }
    } catch (error) {
      throw error;
    }
  }
}

export const buyController = new BuyController();
