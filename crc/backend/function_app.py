import azure.functions as func
import logging
import os
import json

from azure.data.tables import TableClient


app = func.FunctionApp()


@app.route(
    route="VisitorCounter",
    auth_level=func.AuthLevel.ANONYMOUS
)
def VisitorCounter(req: func.HttpRequest) -> func.HttpResponse:

    logging.info("Visitor counter triggered")

    connection_string = os.environ["COSMOS_TABLE_CONNECTION"]

    table_client = TableClient.from_connection_string(
        conn_str=connection_string,
        table_name="visitorCounter"
    )

    entity = table_client.get_entity(
        partition_key="counter",
        row_key="visitors"
    )

    entity["count"] += 1

    table_client.update_entity(entity)

    return func.HttpResponse(
        json.dumps({
            "count": entity["count"]
        }),
        mimetype="application/json"
    )