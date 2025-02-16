from pydantic import BaseModel

class UserCreate(BaseModel):
    username: str
    email: str
    password: str

class PortfolioCreate(BaseModel):
    user_id: int
    asset_symbol: str
    quantity: float
