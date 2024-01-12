import pandas as pd
import json


def convertir_csv_a_json(archivo_csv, archivo_json):
    df = pd.read_csv(archivo_csv, delimiter=";")

    json_data = {"schemaVersion": "", "extractStartDateTime": "", "MarketsList": []}

    for _, row in df.iterrows():
        market_data = {
            "Market": {
                "isoCode": row["Market_isoCode"],
                "storeId": int(row["Market_storeId"]),
            },
            "Interval": {"start": row["Interval_start"], "end": row["Interval_end"]},
            "AverageTicket": {
                "currency": row["AverageTicket_currency"],
                "TiersList": [],
            },
        }

        for column_name, value in row.items():
            if column_name.startswith("TiersList_tier_") and not pd.isna(value):
                tier_number = int(column_name.split("_")[-1])
                amount_column = f"TiersList_amount_{tier_number}"
                if amount_column in df.columns and not pd.isna(row[amount_column]):
                    market_data["AverageTicket"]["TiersList"].append(
                        {
                            "tier": tier_number,
                            "amount": float(row[amount_column].replace(",", ".")),
                        }
                    )

        json_data["schemaVersion"] = row["schemaVersion"]
        json_data["extractStartDateTime"] = row["extractStartDateTime"]
        json_data["MarketsList"].append(market_data)

    with open(archivo_json, "w") as json_file:
        json.dump(json_data, json_file, indent=2)


csv_file_path = "./ETL/MarketAvrgTicketSample.csv"
json_file_path = "resultado.json"

convertir_csv_a_json(csv_file_path, json_file_path)
