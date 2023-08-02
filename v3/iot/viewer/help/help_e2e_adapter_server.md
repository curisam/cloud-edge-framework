
# 본 문서의 목적은 ? 
 - 엔드투엔드 보안어뎁터와 연동되는 서버 구축을 위한 설치 가이드입니다.
 
 
# 서버 구현은 ? 
 - Ubuntu Linux 에서 테스트 되었습니다.
 - Apache + PHP + Mysql을 사용합니다.
 
  
# 도움말을 보여 주려면 ?
 - 마크다운(Markdown) 언어로 도움말을 작성했습니다.
 - PHP 해석기로 ```*.md``` 파일을 시각화 합니다 (예: https://github.com/erusev/parsedown)
 - 도움말 페이지가 필요하시면 관련 파일들을 설치하십시요.
 

# MQTT 프로토콜 사용을 위해 미리 설치하세요
 - 리눅스 터미널에서 paho-mqtt 를 설치합니다.
 
```bash
    pip install --upgrade pip
    pip install paho-mqtt
```

 - (옵션) 하이브리드 앱 개발을 위해서는 Ionic 프레임워크를 설치합니다.

```python
 npm install -g ionic cordova
```



 
 
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






 




# 주의하세요 !
 - 서버와 클라이언트 사이의 데이터 전송을 위해 GET 방식으로 파라미터 전달하고 있습니다.
 - 개발단계에서 디버깅을 용이하게 하기 위함입니다.
 - 실 서비스를 고려하신다면 GET방식은 보안에 취약하니, POST방식 등으로 수정이 필요합니다.

 










# [Bootstrap](http://getbootstrap.com) [![Build Status](https://secure.travis-ci.org/twbs/bootstrap.png)](http://travis-ci.org/twbs/bootstrap) [![devDependency Status](https://david-dm.org/twbs/bootstrap/dev-status.png)](https://david-dm.org/twbs/bootstrap#info=devDependencies)

Bootstrap is a sleek, intuitive, and powerful front-end framework for faster and easier web development, created and maintained by [Mark Otto](http://twitter.com/mdo) and [Jacob Thornton](http://twitter.com/fat).

To get started, check out <http://getbootstrap.com>!



## Quick start

Three quick start options are available:

* [Download the latest release](https://github.com/twbs/bootstrap/archive/v3.0.2.zip).
* Clone the repo: `git clone https://github.com/twbs/bootstrap.git`.
* Install with [Bower](http://bower.io): `bower install bootstrap`.

Read the [Getting Started page](http://getbootstrap.com/getting-started/) for information on the framework contents, templates and examples, and more.

### What's included

Within the download you'll find the following directories and files, logically grouping common assets and providing both compiled and minified variations. You'll see something like this:

```
bootstrap/
├── css/
│   ├── bootstrap.css
│   ├── bootstrap.min.css
│   ├── bootstrap-theme.css
│   └── bootstrap-theme.min.css
├── js/
│   ├── bootstrap.js
│   └── bootstrap.min.js
└── fonts/
    ├── glyphicons-halflings-regular.eot
    ├── glyphicons-halflings-regular.svg
    ├── glyphicons-halflings-regular.ttf
    └── glyphicons-halflings-regular.woff
```

We provide compiled CSS and JS (`bootstrap.*`), as well as compiled and minified CSS and JS (`bootstrap.min.*`). Fonts from Glyphicons are included, as is the optional Bootstrap theme.



## Bugs and feature requests

Have a bug or a feature request? [Please open a new issue](https://github.com/twbs/bootstrap/issues). Before opening any issue, please search for existing issues and read the [Issue Guidelines](https://github.com/necolas/issue-guidelines), written by [Nicolas Gallagher](https://github.com/necolas/).

You may use [this JS Bin](http://jsbin.com/aKiCIDO/1/edit) as a template for your bug reports.



## Documentation

Bootstrap's documentation, included in this repo in the root directory, is built with [Jekyll](http://jekyllrb.com) and publicly hosted on GitHub Pages at <http://getbootstrap.com>. The docs may also be run locally.

### Running documentation locally

1. If necessary, [install Jekyll](http://jekyllrb.com/docs/installation) (requires v1.x).
2. From the root `/bootstrap` directory, run `jekyll serve` in the command line.
  - **Windows users:** run `chcp 65001` first to change the command prompt's character encoding ([code page](http://en.wikipedia.org/wiki/Windows_code_page)) to UTF-8 so Jekyll runs without errors.
3. Open <http://localhost:9001> in your browser, and voilà.

Learn more about using Jekyll by reading its [documentation](http://jekyllrb.com/docs/home/).

### Documentation for previous releases

Documentation for v2.3.2 has been made available for the time being at <http://getbootstrap.com/2.3.2/> while folks transition to Bootstrap 3.

[Previous releases](https://github.com/twbs/bootstrap/releases) and their documentation are also available for download.



## Compiling CSS and JavaScript

Bootstrap uses [Grunt](http://gruntjs.com/) with convenient methods for working with the framework. It's how we compile our code, run tests, and more. To use it, install the required dependencies as directed and then run some Grunt commands.

### Install Grunt

From the command line:

1. Install `grunt-cli` globally with `npm install -g grunt-cli`.
2. Navigate to the root `/bootstrap` directory, then run `npm install`. npm will look at [package.json](package.json) and automatically install the necessary local dependencies listed there.

When completed, you'll be able to run the various Grunt commands provided from the command line.

**Unfamiliar with `npm`? Don't have node installed?** That's a-okay. npm stands for [node packaged modules](http://npmjs.org/) and is a way to manage development dependencies through node.js. [Download and install node.js](http://nodejs.org/download/) before proceeding.

### Available Grunt commands

#### Build - `grunt`
Run `grunt` to run tests locally and compile the CSS and JavaScript into `/dist`. **Uses [recess](http://twitter.github.io/recess/) and [UglifyJS](http://lisperator.net/uglifyjs/).**

#### Only compile CSS and JavaScript - `grunt dist`
`grunt dist` creates the `/dist` directory with compiled files. **Uses [recess](http://twitter.github.io/recess/) and [UglifyJS](http://lisperator.net/uglifyjs/).**

#### Tests - `grunt test`
Runs [JSHint](http://jshint.com) and [QUnit](http://qunitjs.com/) tests headlessly in [PhantomJS](http://phantomjs.org/) (used for CI).

#### Watch - `grunt watch`
This is a convenience method for watching just Less files and automatically building them whenever you save.

### Troubleshooting dependencies

Should you encounter problems with installing dependencies or running Grunt commands, uninstall all previous dependency versions (global and local). Then, rerun `npm install`.



## Contributing

Please read through our [contributing guidelines](https://github.com/twbs/bootstrap/blob/master/CONTRIBUTING.md). Included are directions for opening issues, coding standards, and notes on development.

More over, if your pull request contains JavaScript patches or features, you must include relevant unit tests. All HTML and CSS should conform to the [Code Guide](http://github.com/mdo/code-guide), maintained by [Mark Otto](http://github.com/mdo).

Editor preferences are available in the [editor config](.editorconfig) for easy use in common text editors. Read more and download plugins at <http://editorconfig.org>.

With v3.1, we're moving from the Apache 2 to the MIT license for the Bootstrap code (not the docs). Please see the [contributing guidelines](https://github.com/twbs/bootstrap/blob/master/CONTRIBUTING.md) for more information.


## Community

Keep track of development and community news.

* Follow [@twbootstrap on Twitter](http://twitter.com/twbootstrap).
* Read and subscribe to [The Official Bootstrap Blog](http://blog.getbootstrap.com).
* Have a question that's not a feature request or bug report? [Ask on the mailing list.](http://groups.google.com/group/twitter-bootstrap)
* Chat with fellow Bootstrappers in IRC. On the `irc.freenode.net` server, in the `##twitter-bootstrap` channel.




## Versioning

For transparency and insight into our release cycle, and for striving to maintain backward compatibility, Bootstrap will be maintained under the Semantic Versioning guidelines as much as possible.

Releases will be numbered with the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, please visit <http://semver.org/>.



## Authors

**Mark Otto**

+ <http://twitter.com/mdo>
+ <http://github.com/mdo>

**Jacob Thornton**

+ <http://twitter.com/fat>
+ <http://github.com/fat>



## Copyright and license

Copyright 2013 Twitter, Inc under [the Apache 2.0 license](LICENSE).

