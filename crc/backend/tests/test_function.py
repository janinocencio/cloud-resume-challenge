import json
from unittest.mock import patch, MagicMock

import azure.functions as func

import function_app


def test_visitor_counter_returns_200_and_increments():
    fake_entity = {
        "PartitionKey": "counter",
        "RowKey": "visitors",
        "count": 8
    }

    fake_table_client = MagicMock()
    fake_table_client.get_entity.return_value = fake_entity

    request = func.HttpRequest(
        method="GET",
        body=None,
        url="/api/VisitorCounter",
        params={}
    )

    with patch.dict(
        "os.environ",
        {"COSMOS_TABLE_CONNECTION": "fake-connection-string"}
    ):
        with patch(
            "function_app.TableClient.from_connection_string",
            return_value=fake_table_client
        ):
            response = function_app.VisitorCounter(request)

    assert response.status_code == 200

    response_data = json.loads(response.get_body())
    assert response_data["count"] == 9

    fake_table_client.get_entity.assert_called_once_with(
        partition_key="counter",
        row_key="visitors"
    )

    fake_table_client.update_entity.assert_called_once_with(fake_entity)