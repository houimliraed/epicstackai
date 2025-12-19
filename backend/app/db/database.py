from sqlalchemy.engine import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

from core.config import settings

# Update the engine to use PostgreSQL
engine = create_engine(
    settings.DATABASE_URL,  # Ensure this is a PostgreSQL URL
    echo=True  # Optional: Enable SQLAlchemy logging for debugging
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def create_tables():
    Base.metadata.create_all(bind=engine)
