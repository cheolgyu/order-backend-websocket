use crate::schema::order::{self, dsl::order as tb};
use actix::Handler;
use actix::Message;
use actix::{Actor, SyncContext};
use chrono::NaiveDateTime;
use diesel::pg::PgConnection;
use diesel::prelude::*;
use diesel::r2d2::{ConnectionManager, Pool};
use uuid::Uuid;

#[derive(
    Clone,
    Debug,
    Serialize,
    Associations,
    Deserialize,
    PartialEq,
    Identifiable,
    Queryable,
    Insertable,
)]
//#[has_many(Product)]
#[table_name = "order"]
pub struct Order {
    pub id: i32,
    pub shop_id: Uuid,
    pub state: String,
    pub price: f64,
    pub products: serde_json::Value,
    pub req_session_id: serde_json::Value,
    pub created_at: NaiveDateTime,
    pub updated_at: Option<NaiveDateTime>,
    pub deleted_at: Option<NaiveDateTime>,
}

#[derive(Deserialize, Serialize, Debug, Message, Insertable)]
#[rtype(result = "()")]
#[table_name = "order"]
pub struct NewOrder {
    pub shop_id: Uuid,
    pub state: String,
    pub price: f64,
    pub products: serde_json::Value,
    pub req_session_id: serde_json::Value,
}

pub struct DbExecutor(pub Pool<ConnectionManager<PgConnection>>);

impl Actor for DbExecutor {
    type Context = SyncContext<Self>;
}

impl Handler<NewOrder> for DbExecutor {
    type Result = ();

    fn handle(&mut self, msg: NewOrder, _: &mut Self::Context) -> Self::Result {
        println!("---------2222222");
        let conn = &self.0.get().expect("Error saving new post 11111");

        let aa: Order = diesel::insert_into(tb)
            .values(&msg)
            .get_result::<Order>(conn)
            .expect("Error saving new post");
    }
}
