from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
import schemas, crud, database

router = APIRouter()

@router.post("/portfolio")
def add_portfolio(portfolio: schemas.PortfolioCreate, db: Session = Depends(database.get_db)):
    return crud.add_portfolio(db, portfolio)
