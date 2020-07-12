import mysql from 'mysql';

const { HOST, USER, PASSWORD, DATABASE} = process.env;

export const pool = mysql.createPool({
    /* connectionLimit: 15, */
    host: HOST,
    user: USER,
    password: PASSWORD,
    database: DATABASE,
    /* debug: false */
});

export const queryHandler = async (...args: any): Promise<any> => {
    let client: any;
    try {
      const rows = await new Promise((resolve, reject) => {
        pool.getConnection(async (err: any, connection: any) => {
          if (err) {
            console.log("error:" + err.message);
            throw new Error(`ERROR ${err.message}`);
          }
  
          const rows = await new Promise((resolve, reject) => {
            connection.query(...args, (err: any, rows: any) => {
              if (err) return reject(err);
              resolve(rows);
            });
          });
  
          if (err) return reject(err);
          resolve(rows);
  
          connection.release(true);
          console.log("Connection realease");
        });
      });
  
      return rows;
    } catch (error) {
      throw error;
    } finally {
      if (client) {
        client.release(true);
      }
    }
  };

