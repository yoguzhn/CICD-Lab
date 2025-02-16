import numpy as np
import pandas as pd
import tensorflow as tf
from fastapi import APIRouter

router = APIRouter()

@router.get("/ai-signals/{symbol}")
def get_ai_signals(symbol: str):
    data = pd.read_csv(f"{symbol}.csv")
    model = tf.keras.models.load_model("ai_model.h5")  # Daha önce eğitilmiş model
    predictions = model.predict(data["Close"].values.reshape(-1,1))
    return {"symbol": symbol, "predictions": predictions.tolist()}
