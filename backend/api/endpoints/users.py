from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
import schemas, crud, database

router = APIRouter()

@router.post("/register")
def register(user: schemas.UserCreate, db: Session = Depends(database.get_db)):
    return crud.create_user(db, user)
