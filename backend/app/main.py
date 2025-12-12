from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware




app = FastAPI(
    title="Choose your own adventure Game API",
    description="JUST An API To Generate Some AI Stuff",
    version="1.O",
    docs_url="/docs",
    redoc_url="/redoc"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app",host="0.0.0.0",port=8001,reload=True)