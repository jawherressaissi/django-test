from celery import Celery
from celery.schedules import crontab

app = Celery('ced',
             broker='redis://localhost:6379/0',
             backend='rpc://',
             include=['ced.tasks'])
#app.config_from_object('django.conf:settings')
#app.autodiscover_tasks(lambda : INSTALLED_APPS)

# Optional configuration, see the application user guide.
app.conf.update(
    result_expires=3600,
    worker_cancel_long_running_tasks_on_connection_loss=True
)

app.conf.beat_schedule = {
    'linkedin-benchmark': {
        'task': 'linkedin_benchmark',
        'schedule': crontab(hour=10, minute=15, day_of_week='*')
    },
}

app.conf.enable_utc = False
app.conf.timezone = "Europe/Lisbon"

if __name__ == '__main__':
    app.start()