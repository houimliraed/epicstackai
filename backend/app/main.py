from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
# importing the settings
from core.config import settings




app = FastAPI(
    title="Choose your Own Adventure API",
    description="API to generate cool stories",
    version="1.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins= settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)


@app.get("/")
def home():
    return {'hello':'world'}



if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app",host="0.0.0.0",port=5000,reload=True)