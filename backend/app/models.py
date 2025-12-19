from sqlalchemy import Column, Integer, String, Date
from .database import Base

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, index=True)
    check_in = Column(Date)
    check_out = Column(Date)