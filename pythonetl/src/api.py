from fastapi import FastAPI
from src.utils import simulated_csv_extraction, convert_csv_to_json

app = FastAPI()


@app.get("/transform")
def transform():
    extracted_path = simulated_csv_extraction()

    transformed_data = convert_csv_to_json(
        csv_file_path=extracted_path, json_file_path="./ETL/output/resultado.json"
    )

    return transformed_data
