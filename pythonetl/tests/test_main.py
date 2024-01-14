import pytest
import pandas as pd
from src.utils import create_market_data, load_csv, convert_to_json


def test_load_csv():
    # Test case 1: Valid file path
    file_path = "./ETL/MarketAvrgTicketSample.csv"
    expected_output = pd.read_csv(file_path, delimiter=";")
    assert load_csv(file_path).equals(expected_output)

    # Test case 2: Invalid file path
    file_path = "/path/to/invalid/file.csv"
    with pytest.raises(FileNotFoundError):
        load_csv(file_path)


def test_create_market_data():
    # Test case 1: Valid row data
    row = pd.Series(
        {
            "Market_isoCode": "US",
            "Market_storeId": "123",
            "Interval_start": "2022-01-01",
            "Interval_end": "2022-01-31",
            "AverageTicket_currency": "USD",
            "TiersList_tier_1": "Tier 1",
            "TiersList_amount_1": "10.5",
            "TiersList_tier_2": "Tier 2",
            "TiersList_amount_2": "20.75",
        }
    )
    expected_output = {
        "Market": {"isoCode": "US", "storeId": 123},
        "Interval": {"start": "2022-01-01", "end": "2022-01-31"},
        "AverageTicket": {
            "currency": "USD",
            "TiersList": [
                {"tier": 1, "amount": 10.5},
                {"tier": 2, "amount": 20.75},
            ],
        },
    }
    assert create_market_data(row) == expected_output

    # Test case 2: Missing tier amount
    row = pd.Series(
        {
            "Market_isoCode": "US",
            "Market_storeId": "123",
            "Interval_start": "2022-01-01",
            "Interval_end": "2022-01-31",
            "AverageTicket_currency": "USD",
            "TiersList_tier_1": "Tier 1",
            "TiersList_amount_1": "10.5",
            "TiersList_tier_2": "Tier 2",
        }
    )
    expected_output = {
        "Market": {"isoCode": "US", "storeId": 123},
        "Interval": {"start": "2022-01-01", "end": "2022-01-31"},
        "AverageTicket": {
            "currency": "USD",
            "TiersList": [{"tier": 1, "amount": 10.5}],
        },
    }
    assert create_market_data(row) == expected_output


def test_convert_to_json():
    # Test case 1: Valid DataFrame
    df = pd.DataFrame(
        {
            "schemaVersion": ["1.0", "1.0"],
            "extractStartDateTime": ["2022-01-01", "2022-01-01"],
            "Market_isoCode": ["US", "UK"],
            "Market_storeId": ["123", "456"],
            "Interval_start": ["2022-01-01", "2022-01-01"],
            "Interval_end": ["2022-01-31", "2022-01-31"],
            "AverageTicket_currency": ["USD", "GBP"],
            "TiersList_tier_1": ["Tier 1", "Tier 1"],
            "TiersList_amount_1": ["10.5", "20.75"],
            "TiersList_tier_2": ["Tier 2", "Tier 2"],
            "TiersList_amount_2": ["15.0", "25.0"],
        }
    )
    expected_output = {
        "schemaVersion": "1.0",
        "extractStartDateTime": "2022-01-01",
        "MarketsList": [
            {
                "Market": {"isoCode": "US", "storeId": 123},
                "Interval": {"start": "2022-01-01", "end": "2022-01-31"},
                "AverageTicket": {
                    "currency": "USD",
                    "TiersList": [
                        {"tier": 1, "amount": 10.5},
                        {"tier": 2, "amount": 15.0},
                    ],
                },
            },
            {
                "Market": {"isoCode": "UK", "storeId": 456},
                "Interval": {"start": "2022-01-01", "end": "2022-01-31"},
                "AverageTicket": {
                    "currency": "GBP",
                    "TiersList": [
                        {"tier": 1, "amount": 20.75},
                        {"tier": 2, "amount": 25.0},
                    ],
                },
            },
        ],
    }
    assert convert_to_json(df) == expected_output