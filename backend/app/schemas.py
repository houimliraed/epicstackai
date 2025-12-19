from pydantic import BaseModel
from datetime import date

class ReservationBase(BaseModel):
    name: str
    email: str
    check_in: date
    check_out: date

class ReservationCreate(ReservationBase):
    pass

class Reservation(ReservationBase):
    id: int

    class Config:
        orm_mode = True