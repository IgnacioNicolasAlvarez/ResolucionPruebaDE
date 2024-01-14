import pandas as pd
import json


def load_csv(file_path):
    return pd.read_csv(file_path, delimiter=";")


def create_market_data(row):
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
            if amount_column in row.index and not pd.isna(row[amount_column]):
                market_data["AverageTicket"]["TiersList"].append(
                    {
                        "tier": tier_number,
                        "amount": float(row[amount_column].replace(",", ".")),
                    }
                )

    return market_data


def convert_to_json(df):
    json_data = {"schemaVersion": "", "extractStartDateTime": "", "MarketsList": []}

    for _, row in df.iterrows():
        market_data = create_market_data(row)

        json_data["schemaVersion"] = row["schemaVersion"]
        json_data["extractStartDateTime"] = row["extractStartDateTime"]
        json_data["MarketsList"].append(market_data)

    return json_data


def save_to_json(json_data, file_path):
    with open(file_path, "w") as json_file:
        json.dump(json_data, json_file, indent=2)


def convert_csv_to_json(csv_file_path, json_file_path):
    df = load_csv(csv_file_path)
    json_data = convert_to_json(df)
    save_to_json(json_data, json_file_path)
