<style>
	table {
		border-collapse:collapse;
		width: 100%;
	}
	th, td {
		padding:4px;
		border: 1px solid #ddd;
	}

	/* TABLES */
	table {
		border: 1px solid #DDD; 
		margin: 15px 0;    
		width: 100%;		     	
	}     

	table tr > th {
		background-color: #f5f5f5;
		font-weight: normal;
		text-align: left;
	}
	table tr > th:first-child {
		font-weight: bold;
	}
	     
	tr:nth-child(even) > td {
		background-color: #f5f5f5;
	}

	table td,
	table th {
		border-left: 1px solid #DDD;
		border-top: 1px solid #DDD;
		line-height: 20px;
		padding: 8px;
		vertical-align: top;
	}     
	table td:first-child {
		font-weight: bold;
	}     


	/* colored table */
	.colored-table {
	color: black;
	}
	.colored-table .row-red > td {
		background-color: #FF0000; 
	}
	.colored-table .row-yellow > td {
		background-color: #ffff00;
	}
	.colored-table .row-lightgreen > td {
		background-color: #92d050;
	}   
	.colored-table .row-green > td {
		background-color: #00cc00;
	}
	.colored-table .row-blue > td {
		background-color: #0070c0;
	}
	.colored-table .row-magenta > td {
		background-color: #ff00ff;
	}
</style>


<h1> 전자부품연구원, 보안 호환 스마트기기, IoT 기기의 인증 등록 절차 설계 및 개발 </h1>


---------------------------------------------------------------
Contents
--------

* [1. 도움말](#helpMain)
    * [1.1. 개발자님 꼭 읽으세요](#helpNotice)
	
    * [1.1. 테스트시 꼭 읽으세요](#helpTest)
	
    * [1.1.1 Response](#helpProcedure)
    * [1.1.2 Response](#gatewayApi1-2)
    * [1.1.3 Response](#gatewayApi1-2)

* [2. Service API](#serviceyApi)
* [Markdown examples](#gateway_api)





---------------------------------------------------------------
# <a id="helpNotice"></a> 개발자님 꼭 읽으세요

## <a id="helpNoticeSub1"></a> 주요 개발환경
 
 - 개발 언어 : PHP + Python 3.x 입니다. 
 - 필요 플랫폼 : 아파치, mysql, php가 설치된 서버 환경이 필요합니다.
 - 연동 종류 : 보안서버, 스마트단말, IoT기기로 구성됩니다.
 - 검증할 내용 : 보안서버가 스마트단말과 Iot 기기를 인증하는 것이 목적입니다. 

## <a id="helpNoticeSub1"></a> 미리 설치하세요
 
 - paho-mqtt 를 설치합니다.
```bash
   pip install --upgrade pip
   pip install paho-mqtt
```

Ionic 프레임워크를 설치합니다. ==> 하이브리드 앱 개발을 위함  
```bash
 npm install -g ionic cordova
```

## <a id="helpNoticeSub2"></a> 제약조건 
 
 - 모든 페이지는 디버깅을 위해 GET 방식으로 파라미터 전달합니다. ==> 사업화 고려 당사자는 POST방식 등의 보안성 높은 방법으로 수정해야 합니다.

 
---------------------------------------------------------------
# <a id="helpTest"></a> 테스트 방법
 
 
## <a id="helpNotice"></a> 기 확보된 정보 
 
 - 한국사물인증센터로부터 사전에 ID, PW를 발급 받습니다.
 - 한국사물인증센터 사전에 단말용 인증키를 발급 받습니다. (스마트단말, Iot 단말 각각 독립적으로 1개씩)

## <a id="helpNotice"></a> 기 확보된 정보 
 
 - ID, PW, 단말용 인증키를 준비합니다.(없으면 한국사물인증센터에서 발급받습니다.)
 - 스마트단말에서 브라우저를 열어 서비스 페이지에 접속합니다.(http://ketihhc.iptime.org/2017seciot)
  > 스마트단말에 앱을 설치하여 보안 인증하는 경우에는 ID/PW만 입력합니다. 이때는 한국사물인증센터에서 배포한 앱에 대해서만 보안인증을 보장합니다. 
 - ID, PW로 로그인 합니다.(http://ketihhc.iptime.org/2017seciot/step1_login.php)
  > 시험계정 ID: testuser, PW: testuser 
 - 무결성 검증 정보들을 보안인증서버에 전달합니다.(http://ketihhc.iptime.org/2017seciot/step2_verify_integrity.php)
  > 시험 디바이스 정보: "KETI Smart Device 1", 시험 시리얼번호: "AAAA0001"
 - (UI 없는 부분) 무결성 검증을 수행합니다.
 - 무결성 검증이 완료되면 보안인증 서버에서 생성한 난수값을 확인합니다.
 - (UI 없는 부분) 무결성 검증이 완료되면 연동된 Iot장치들에게 
 
## <a id="introApi2"></a> RESTful API ?
- 기기들의 상태정보를 획득하고, 제어하기 위해 RESTful 방식의 인터페이스를 기술함



 
## <a id="Tip1"></a> RESTful API ?
- MQTT mosquitto DB 클리닝  

```bash
#!/bin/bash
sudo service mosquitto stop
sudo rm /var/lib/mosquitto/mosquitto.db
sudo service mosquitto start
```


Notes
-----

* [Note] "Markdown preview" plugin is very useful, to see *.md file nicely in your browser
 - Chrome : TODO : markdown plus 
 - Chrome : https://github.com/borismus/markdown-preview


























Contents
--------

* [1. Gateway API](#gatewayApi)
    * [1.1. Get all gateways](#gatewayApi1)
    * [1.1.1 Response](#gatewayApi1-1)
    * [1.1.2 Response](#gatewayApi1-2)
    * [1.1.3 Response](#gatewayApi1-2)

* [2. Service API](#serviceyApi)
* [Markdown examples](#gateway_api)


Notes
-----

* [Note] "Markdown preview" plugin is very useful, to see *.md file nicely in your browser
 - Firefox: TODO  
 - Chrome : TODO : markdown plus 
 - Chrome : https://github.com/borismus/markdown-preview


# <a id="introApi"></a> Introduction <small> to Hybrid Home Cloud API </small>


## <a id="introApi1"></a> Home Cloud ? 
- 스마트 가전 기기들과 클라우드 시스템이 상호 연동하여 다양한 서비스를 제공할 수 있는 통합 프레임워크임

## <a id="introApi2"></a> RESTful API ?
- 기기들의 상태정보를 획득하고, 제어하기 위해 RESTful 방식의 인터페이스를 기술함

## <a id="introApi3"></a> Full API tree 

```bash
/api/<username>/gateways/          GET
/api/<username>/gateways/_id       GET
/api/<username>/gateways/          POST
/api/<username>/gateways/_id       PUT
/api/<username>/gateways/_id       DELETE

/api/<username>/services/          GET
/api/<username>/services/_id       GET
/api/<username>/services/          POST
/api/<username>/services/_id       PUT
/api/<username>/services/_id       DELETE

/api/<username>/contexts/          GET
/api/<username>/contexts/_id       GET
/api/<username>/contexts/          POST
/api/<username>/contexts/_id       PUT
/api/<username>/contexts/_id       DELETE

/api/<username>/layouts/           GET
/api/<username>/layouts/_id        GET
/api/<username>/layouts/           POST
/api/<username>/layouts/_id        PUT
/api/<username>/layouts/_id        DELETE

/api/<username>/cameras            GET
/api/<username>/cameras/_id        GET
/api/<username>/cameras            POST
/api/<username>/cameras/_id        PUT
/api/<username>/cameras/_id        DELETE
```





# <a id="gatewayApi"></a> 1. Gateway API


## <a id="gatwayApi1"></a> 1.1. Get all gateways

| Method | URL | Action |
| -----------|-----------|-----------|
| `GET` | `/api/<username>/gateways`| Get all gateways |
| `GET` | `/api/<username>/gateways/53343121122222` | Retrieve the gateway with the specified _id |
| `POST` | `/api/<username>/gateways`| Add a new gateway |
| `PUT` | `/api/<username>/gateways/53343121122222` | Update gateway with the specified _id |
| `DELETE` | `/api/<username>/gateways/53343121122222` | Delete the gateway with the specified _id |


e.g. 
<pre>
<code>
# Get gateway lists of user1
http://{home cloud server ip}:8000/api/user1/gateways

</code>
</pre>


## <a id="gatwayApi1"></a> 1.1.1. Description




<pre>
<code>
{
    "devices": {
        "device1": {
            "state": {
                "on": false,
                "reachable": true
            },
            "type": "TV",
            "name": "Smart TV",
            "location": {
                "space_id": "space1",
                "coordinate": { 
                    "x": "none",
                    "y": "none",
                    "z": "none"
                }
            }
        },
        "device2": {
            "state": {
                "on": false,
                "reachable": true
            },
            "type": "Light",
            "name": "Hue",
            "location": {
                "space_id": "space2",
                "coordinate": { 
                    "x": "none",
                    "y": "none",
                    "z": "none"
                }
            }
        }
    },
    "vresource": {
        "vresource1": {
            "name": "Virtual Resource 1",
            "devices": ["device1", "device2"]
        }
    },
    "config": {
        "name": "KETI Home Cloud",
        "ipaddress": "192.168.1.74",
        "gateway": "192.168.1.254",
        "UTC": "2012-10-29T12:00:00",
        "swversion": "01003372",
        "reserved"
    },
    "schedules": {
        "schedule1": {
            "name": "schedule",
            "description": "",
            "command": {
                "address": "/api/<username>/device/1/state",
                "body": {
                    "on": true
                },
                "method": "PUT"
            },
            "time": "2014-01-16T12:00:00"
        }
    },
    "spaces": {
        "space1": {
            "name": "Home",
            "description": "",
            "layout": "/layouts/home.topo.json",
            "state": {
                "isempty": false,
                "last event time": "2014-01-16T12:00:00"
            }
        },
        "space2": {
            "name": "Room1",
            "description": "",
            "layout": "/layouts/home-room1.topo.json",
            "state": {
                "isempty": true,
                "last event time": "2014-01-16T12:00:00"
            }
        },
        "space3": {
            "name": "Room2",
            "description": "",
            "layout": "/layouts/home-room2.topo.json",
            "state": {
                "isempty": false,
                "last event time": "2014-01-16T12:00:00"
            }
        }
    }
}

</code>
</pre>




## <a id="dataModel"></a> x.x. Examples of Data Model (for Mongbo DB, JSON format)
<pre>
<code>
# user
{
    "_id": "113322322233",
    "user_id": "Joe",
    "name": "Joe Adams",
    "password": "JoePassword"
}

# gateway
{
    "_id": "1113333435233",
    "title": "Gateway",
    "ipaddr": "200.111.111.111:8000",
    "model": "KAON M110"
    "user_id": "Joe"
}

# device 
{
    "_id": "4233223344564",
    "device_id": "device1",
    "type": "TV",
    "name": "Smart TV",
    "location": {
        "space_id": "space1",
        "corrdinate": {
            "x": "none",
            "y": "none",
            "z": "none"
        }
    },
    "user_id": "Joe"
}

# space 
{
    "_id": "4233223344564",
    "space_id": "space1",
    "name": "Home",
    "description": "",
    "layout": "/data/home.layout.json",
    "num of rooms": 4,
    "topology": "/data/home.graph.json",
    "state": {
        "isempty": true,
        "last event time": "2014-01-16T12:00:00"
    },
    "user_id": "Joe"
}


# graph json
# http://bl.ocks.org/mbostock/3750558
{
    "nodes": [
        {"x": 669, "y": 110},
        {"x": 493, "y": 364},
        {"x": 493, "y": 364},
        {"x": 442, "y": 565}
    ],
    "links": [
        {"source":  0, "target":  1},
        {"source":  1, "target":  2},
        {"source":  1, "target":  2},
        {"source":  2, "target":  0}
    ]
}





# layout : topojson
{
    "_id": "544333434555",
    "description": "living room",
    "user_id": "Joe",
    {
        "type":"Topology",
        "transform":
        {
            "scale": [1,1],
            "translate": [0,0]
        },
        "objects":
        { "two-squares":
            {
                "type": "GeometryCollection",
                "geometries":
                [
                    {"type": "Polygon", "arcs":[[0,1]],"properties": {"name": "Left_Polygon" }},
                    {"type": "Polygon", "arcs":[[2,-1]],"properties": {"name": "Right_Polygon" }}
                ]
            }
        },
        "one-line":
        {
            "type":"GeometryCollection",
            "geometries":
            [
                {"type": "LineString", "arcs": [3],"properties":{"name":"Under_LineString"}}
            ]
        },
        "two-places":
        {
            "type":"GeometryCollection",
            "geometries":
            [
                {"type":"Point","coordinates":[0,0],"properties":{"name":"Origine_Point"}},
                {"type":"Point","coordinates":[0,-2],"properties":{"name":"Under_Point"}}
            ]
        }
        "arcs":
        [
            [[1,2],[0,-2]],
            [[1,0],[-1,0],[0,2],[1,0]],
            [[1,2],[1,0],[0,-2],[-1,0]],
            [[0,-1],[2,0]]
        ]
    }
}

# location : geojson
{
    "1": {
        "name": "Bedroom"
    },
    "2": {
        "name": "Kitchen"
    }
}
</code>
</pre>


























# <a id="markdownExamples"> Markdown examples </a>



~~~
this is a code block
~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~.html
<p>paragraph <b>emphasis</b>
~~~~~~~~~~~~~~~~~~~~~~~~~~~


First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell


<table>
<thead>
<tr>
  <th>First Header</th>
  <th>Second Header</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Content Cell</td>
  <td>Content Cell</td>
</tr>
<tr>
  <td>Content Cell</td>
  <td>Content Cell</td>
</tr>
</tbody>
</table>





<pre>
<code>
:::python
import cv2

img = cv2.read('hello.jpg')
cv2.imshow('hi', img)
print "hello"

</code>
</pre>

~~~~~
<a href="#">My code</a>
~~~~~




| One | Two   |
|-----+-------|
| my  | table |
| is  | nice  |




| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

 First Header   | Second Header
  -------------  | -------------
  *Content Cell* | Content Cell
  Content Cell   | Content Cell


| Function name | Description                    |
| ------------- | ------------------------------ |
| `help()`      | Display the help window.       |
| `destroy()`   | **Destroy your computer!**     |


Apple
:   Pomaceous fruit of plants of the genus Malus in 
    the family Rosaceae.

Orange
:   The fruit of an evergreen tree of the genus Citrus.



Apple
:   Pomaceous fruit of plants of the genus Malus in 
    the family Rosaceae.
:   An American computer company.

Orange
:   The fruit of an evergreen tree of the genus Citrus.














## 1.1.1. Description 



## 1.1.2. Resonse



## 1.1.3. Response example 









DESCRIPTION
----------------------------


SYSTEM REQUIREMENTS

한글 

* Hello
    * [SECTION ONE](#sect one)
        * [SECTION TWO](#sect two)
            * SECTION THREE
        * [SECTION FOUR](#four)

## SECT## <a id="sect one"></a>SECTION ONE ##

something here

### <a id='sect two'>eh</a>SECTION TWO ###

something else

#### SECTION THREE

nothing here

### <a id="four"></a>SECTION FOUR


# 1
## 2
### 3
#### 4
##### 5




## BUILDING THE GEM FROM MASTER

```bash
$ gem uninstall -aIx gollum
$ git clone https://github.com/gollum/gollum.git
$ cd gollum
gollum$ rake build
gollum$ gem install --no-ri --no-rdoc pkg/gollum*.gem
```

## WORK WITH TEST REPOS

An example of how to add a test file to the bare repository lotr.git.

```bash
$ mkdir tmp; cd tmp
$ git clone ../lotr.git/ .
Cloning into '.'...
done.
$ git log
$ echo "test" > test.md
$ git add . ; git commit -am "Add test"
$ git push ../lotr.git/ master
```


# KETI Restful API 


KETI Restful API 
----------------


#### Note


# KETI Home Cloud 2014, Home Context Awareness Module


## usage
1. aaa
2. bbb

* empha




# SVN commands

## initial checkout ##
svn checkout svn://abcs.keti.re.kr/HHC/src/HomeMonitoringServer/

## file add, delete & update ##
svn add . --force
svn update ./ svn://abcs.keti.re.kr/HHC/src/HomeMonitoringServer/
svn delete a.txt b.txt // example

## commit ##
svn update 
svn commit -m "log message" 



# (Origianal code) Node Cellar Sample Application with Backbone.js, Twitter Bootstrap, Node.js, Express, and MongoDB #

"Node Cellar" is a sample CRUD application built with with Backbone.js, Twitter Bootstrap, Node.js, Express, and MongoDB.

The application allows you to browse through a list of wines, as well as add, update, and delete wines.

This application is further documented [here](http://coenraets.org/blog).

The application is also hosted online. You can test it [here](http://nodecellar.coenraets.org).





# hello, This is Markdown Live Preview

----
## what is Markdown?
see [Wikipedia](http://en.wikipedia.org/wiki/Markdown)

> Markdown is a lightweight markup language, originally created by John Gruber and Aaron Swartz allowing people "to write using an easy-to-read, easy-to-write plain text format, then convert it to structurally valid XHTML (or HTML)".

----
## usage
1. Write markdown text in this textarea.
2. Click 'HTML Preview' button.

----
## markdown quick reference
# headers

*emphasis*

**strong**

* list

>block quote

    code (4 spaces indent)
[links](http://wikipedia.org)

----
## changelog
* 17-Feb-2013 re-design

----
## thanks
* [markdown-js](https://github.com/evilstreak/markdown-js)





















An h1 header
============

Paragraphs are separated by a blank line.

2nd paragraph. *Italic*, **bold**, `monospace`. Itemized lists
look like:

  * this one
  * that one
  * the other one

Note that --- not considering the asterisk --- the actual text
content starts at 4-columns in.

> Block quotes are
> written like so.
>
> They can span multiple paragraphs,
> if you like.

Use 3 dashes for an em-dash. Use 2 dashes for ranges (ex. "it's all in
chapters 12--14"). Three dots ... will be converted to an ellipsis.



An h2 header
------------

Here's a numbered list:

 1. first item
 2. second item
 3. third item

Note again how the actual text starts at 4 columns in (4 characters
from the left side). Here's a code sample:

    # Let me re-iterate ...
    for i in 1 .. 10 { do-something(i) }

As you probably guessed, indented 4 spaces. By the way, instead of
indenting the block, you can use delimited blocks, if you like:

~~
define foobar() {
    print "Welcome to flavor country!";
}
~~

(which makes copying & pasting easier). You can optionally mark the
delimited block for Pandoc to syntax highlight it:

~~python
import time
# Quick, count to ten!
for i in range(10):
    # (but not *too* quick)
    time.sleep(0.5)
    print i
~~



### An h3 header ###

Now a nested list:

 1. First, get these ingredients:

      * carrots
      * celery
      * lentils

 2. Boil some water.

 3. Dump everything in the pot and follow
    this algorithm:

        find wooden spoon
        uncover pot
        stir
        cover pot
        balance wooden spoon precariously on pot handle
        wait 10 minutes
        goto first step (or shut off burner when done)

    Do not bump wooden spoon or it will fall.

Notice again how text always lines up on 4-space indents (including
that last line which continues item 3 above). Here's a link to [a
website](http://foo.bar). Here's a link to a [local
doc](local-doc.html). Here's a footnote [^1].

[^1]: Footnote text goes here.

Tables can look like this:

size  material      color
----  ------------  ------------
9     leather       brown
10    hemp canvas   natural
11    glass         transparent

Table: Shoes, their sizes, and what they're made of

(The above is the caption for the table.) Here's a definition list:

apples
  : Good for making applesauce.
oranges
  : Citrus!
tomatoes
  : There's no "e" in tomatoe.

Again, text is indented 4 spaces. (Alternately, put blank lines in
between each of the above definition list lines to spread things
out more.)

Inline math equations go in like so: $\omega = d\phi / dt$. Display
math should get its own line and be put in in double-dollarsigns:

$$I = \int \rho R^{2} dV$$

Done.



Colons can be used to align columns.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

The outer pipes (|) are optional, and you don't need to make the raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3



