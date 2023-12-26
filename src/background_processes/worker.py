import dramatiq
import requests
from dramatiq.brokers.rabbitmq import RabbitmqBroker

rabbitmq_broker = RabbitmqBroker(url="amqp://user:password@rabbitmq:5672/")
dramatiq.set_broker(rabbitmq_broker)


@dramatiq.actor
def count_words(url: str) -> None:
    response = requests.get(url)
    count = len(response.text.split(" "))
    print(f"There are {count} words at {url!r}.")
