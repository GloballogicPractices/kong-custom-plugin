# kong-custom-plugin
Trying to help people who really want to work with KONG API gateway custom plugin.

![image](https://user-images.githubusercontent.com/26079118/32907810-620cb910-cb27-11e7-845c-1c32183f4e8c.png)

## What is KONG?

Kong is a scalable, open source API Gateway. Kong runs in front of any RESTful API and is extended through Plugins, which provide extra functionality and services beyond the core platform.

* Scalable: Kong easily scales horizontally by simply adding more machines, meaning your platform can handle virtually any load while keeping latency low.

* Modular: Kong can be extended by adding new plugins, which are easily configured through a RESTful Admin API.

* Runs on any infrastructure: Kong runs anywhere. You can deploy Kong in the cloud or on-premise environments, including single or multi-datacenter setups and for public, private or invite-only APIs.

Kong is built on top of reliable technologies like NGINX and Apache Cassandra or PostgreSQL, and provides you with an easy-to-use RESTful API to operate and configure the system.

![image](https://user-images.githubusercontent.com/26079118/32896628-8e0f7a8e-cb09-11e7-9db7-7b27fdc828ca.png)

## What is KONG Plugin?

kong has plugins oriented architecture. All of these Kong plugins give you the power to transform the requests and responses, to control the access of APIs, to log and measure the APIs calls, etc.

![image](https://user-images.githubusercontent.com/26079118/32907814-66d82e20-cb27-11e7-8800-feebccf60c8f.png)

In some cases when existing pluging does not solve your problem than you have to write custom plugin.
Check available plugins detail at https://konghq.com/plugins/ 

* Installation
  * Go inside the KONG container 
    * docker exec -it kong-container-id bash
  
  * Download code 
    * git clone https://github.com/VaibhavG10/kong-custom-plugin.git
  
  * Set Environment Variables
    * export KONG_CUSTOM_PLUGINS="kong-custom-plugin"
    * export KONG_LUA_PACKAGE_PATH="/kong-custom-plugin/lua_modules/share/lua/5.1/kong/plugins/kong-custom-plugin/?.lua"
  
  * Build & Deploy plugin
    * cd kong-custom-plugin
    * luarocks make
    * make install-dev
    * kong reload -vv
  * View Plugin
  
  ![image](https://user-images.githubusercontent.com/26079118/32964024-d493fe64-cbf7-11e7-9bde-3c4afa29d54c.png)
  
  * Custom Plugin after creation
	
	![image](https://user-images.githubusercontent.com/26079118/32963980-af98f10a-cbf7-11e7-8e2b-24f848a538cb.png)
	
  * Test Plugin
    * Create Test API
      * curl -i -X POST --url http://localhost:8001/apis/ --data 'name=TestAPI1' --data 'hosts=' --data 'upstream_url=http://httpbin.org' --data 'uris=/TestUri'
	
	![image](https://user-images.githubusercontent.com/26079118/32963915-8118409c-cbf7-11e7-8f65-7545e27d0f53.png)
	* Hit Test API
	  * curl -i -X GET http://serverIP:8000/TestUri or Hit on Browser http://serverIP:8000/TestUri
    * Tail Error Log File
	  * tail -f /usr/local/kong/logs/error.log
	
	![image](https://user-images.githubusercontent.com/26079118/32964288-ba325380-cbf8-11e7-8d77-3ec421f4c74c.png)
	
* Remove a plugin
  There are three steps to completely remove a plugin.

    * Remove the plugin from your Kong api configuration. Make sure that it is no longer applied globally nor for any API or consumer. This has to be done only once for the entire Kong cluster, no restart/reload required. This step in itself will make that the plugin is no longer in use. But it remains available and it is still possible to re-apply the plugin.

    * Remove the plugin from the custom_plugins directive (on each Kong node). Make sure to have completed step 1 before doing so. After this step it will be impossible for anyone to re-apply the plugin to any Kong api, consumer, or even globally. This step requires to restart/reload the Kong node to take effect.

    * To remove the plugin thoroughly, delete the plugin-related files from each of the Kong nodes. Make sure to have completed step 2, including restarting/reloading Kong, before deleting the files. If you used LuaRocks to install the plugin, you can do luarocks remove <plugin-name> to remove it
	
* Next
    * You can write your custom bussiness logic at handler.lua file.
    * You can refer existing official kong plugin code for more detail.
