bootstrap:
	vagrant up

indices:
	curl http://10.20.30.11:9200/_cat/indices?v

test: clean
	curl http://10.20.30.11:9200/
	curl http://10.20.30.11:9200/_cat/indices?v
	curl http://10.20.30.11:9200/_template/customer-data -X PUT -d @template.json
	sleep 1
	curl http://10.20.30.11:9200/customer-data-xyz/customer/e4eb5672-86d4-4e56-98ea-0ab727c94585 -d @data.json
	sleep 1
	curl http://10.20.30.11:9200/_cat/indices?v

clean:
	curl -X DELETE http://10.20.30.11:9200/*
