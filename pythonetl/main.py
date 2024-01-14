from src.utils import convert_csv_to_json

csv_file_path = "./ETL/MarketAvrgTicketSample.csv"
json_file_path = "./ETL/output/resultado.json"

if __name__ == "__main__":
    convert_csv_to_json(csv_file_path, json_file_path)
