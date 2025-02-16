from sqlalchemy.orm import Session
import models, schemas

# Kullanıcı oluşturma
def create_user(db: Session, user: schemas.UserCreate):
    db_user = models.User(username=user.username, email=user.email, password_hash=user.password)
    db.add(db_user)
    db.commit()
    return db_user

# Kullanıcıyı ID ile bulma
def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.user_id == user_id).first()

# Portföy ekleme
def add_portfolio(db: Session, portfolio: schemas.PortfolioCreate):
    db_portfolio = models.Portfolio(user_id=portfolio.user_id, asset_symbol=portfolio.asset_symbol, quantity=portfolio.quantity)
    db.add(db_portfolio)
    db.commit()
    return db_portfolio
