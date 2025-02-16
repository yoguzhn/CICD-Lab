from fastapi import FastAPI
from database import engine, Base
import api.endpoints.users as users
import api.endpoints.portfolio as portfolio
import api.endpoints.ai_signals as ai_signals

app = FastAPI()

# Veritabanını oluştur
Base.metadata.create_all(bind=engine)

# Routerları ekle
app.include_router(users.router, prefix="/users", tags=["Users"])
app.include_router(portfolio.router, prefix="/portfolio", tags=["Portfolio"])
app.include_router(ai_signals.router, prefix="/ai-signals", tags=["AI Signals"])

@app.get("/")
def home():
    return {"message": "Yatırım Takip API'si Çalışıyor!"}
