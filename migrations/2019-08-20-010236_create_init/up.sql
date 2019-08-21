-- Your SQL goes here

CREATE TABLE "order" (

  id SERIAL PRIMARY KEY,
  shop_id UUID NOT NULL,
  state VARCHAR NOT NULL,
  price float8 NOT NULL,
  
  products jsonb NOT NULL,
  req_session_id jsonb NOT NULL,
  
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  updated_at TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ,
  deleted_at TIMESTAMP  
);
