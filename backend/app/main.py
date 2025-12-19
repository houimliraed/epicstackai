from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from . import models, schemas, crud
from .database import SessionLocal, engine

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/reservations/", response_model=schemas.Reservation)
def create_reservation(reservation: schemas.ReservationCreate, db: Session = Depends(get_db)):
    return crud.create_reservation(db=db, reservation=reservation)

@app.get("/reservations/", response_model=list[schemas.Reservation])
def read_reservations(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return crud.get_reservations(db=db, skip=skip, limit=limit)