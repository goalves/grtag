# Github Repository Tag API



# Group GRTagWeb.Repositories
## GRTagWeb.Repositories [/api/v1/repositories]
### GRTagWeb.Repositories index [GET /api/v1/repositories]


+ Request List Repositories
**GET**&nbsp;&nbsp;`/api/v1/repositories`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2tv2pZXDqi60AAAcD
    + Body
    
            {
              "data": [
                {
                  "description": "Et unde perspiciatis rerum quas ex qui? Labore dolorum nostrum occaecati esse et. Culpa esse quae architecto nam dolores quia.",
                  "github_id": 723040205,
                  "id": "1991827f-29de-4d35-8f54-adcb14509944",
                  "language": "quo",
                  "name": "eaque",
                  "url": "http://flatley.name"
                },
                {
                  "description": "Cumque rerum sit fugiat qui. Nihil eaque ut nihil. Sint earum ut qui quo aut aliquam ex! Qui beatae rerum occaecati ipsam quidem quo. Blanditiis dolore molestias architecto quasi animi quibusdam nostrum soluta quia!",
                  "github_id": 945816364,
                  "id": "f1929994-54f1-4a3f-9a52-4ffbf973c32f",
                  "language": "cum",
                  "name": "aut",
                  "url": "https://wisoky.org"
                },
                {
                  "description": "Praesentium non animi facilis velit molestiae qui repellat. Accusantium aspernatur qui ea nihil itaque. Aliquam magni architecto distinctio modi totam blanditiis vel.",
                  "github_id": 501490714,
                  "id": "a3e00a36-e003-4651-92c2-59c220932bd3",
                  "language": "animi",
                  "name": "optio",
                  "url": "http://leannon.info"
                },
                {
                  "description": "Et dolores aspernatur recusandae? Placeat aut illo sint et ducimus soluta hic aliquam! Maxime perferendis nobis natus et numquam. Consequuntur alias qui quos modi necessitatibus soluta illum.",
                  "github_id": 311326755,
                  "id": "d4571d87-11f7-43be-9ace-89a2a6cb9487",
                  "language": "et",
                  "name": "harum",
                  "url": "https://ohara.name"
                },
                {
                  "description": "Soluta quae non dolores nostrum quae dolorem aliquam soluta corrupti? Ab autem delectus nisi quam corrupti beatae provident dolorem est. Non alias pariatur reiciendis ullam est maxime ex! Est non sapiente voluptatem amet recusandae perferendis eligendi nam. Quia qui quidem et dolor voluptatem omnis iure?",
                  "github_id": 597447525,
                  "id": "bc2bc01b-a687-4967-a75b-75e2ad56eb0e",
                  "language": "et",
                  "name": "quasi",
                  "url": "http://emmerich.net"
                }
              ]
            }
### GRTagWeb.Repositories show [GET /api/v1/repositories/{id}]


+ Request Fetch Repository
**GET**&nbsp;&nbsp;`/api/v1/repositories/dd15d6f3-04d1-4fbf-bc5a-d9443edf9472`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2tv37v3giGpQAAAIK
    + Body
    
            {
              "data": {
                "description": "Iure expedita deleniti fugit. Commodi laudantium est eveniet doloremque fugiat? Pariatur qui nisi qui facere?",
                "github_id": 443584618,
                "id": "dd15d6f3-04d1-4fbf-bc5a-d9443edf9472",
                "language": "dolorem",
                "name": "ducimus",
                "url": "https://mohr.org"
              }
            }


+ Request Fetch Repository fails when repository does not exist
**GET**&nbsp;&nbsp;`/api/v1/repositories/31a17012-7809-4f57-8b9b-29a20edb16ac`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2tv0M4wgG1dEAAAOB
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }

# Group GRTagWeb.Tags
## GRTagWeb.Tags [/api/v1/users/f766bd60-f1df-474c-82e7-0cfda9d9879a/tags]
### GRTagWeb.Tags create [POST /api/v1/users/352cd31b-f13b-477b-ba35-483d9d53ef53/{id}]


+ Request Create Tag for an User
**POST**&nbsp;&nbsp;`/api/v1/users/f766bd60-f1df-474c-82e7-0cfda9d9879a/tags`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "tag": {
                "name": "fugiat",
                "repository_id": "ce3c543b-21ac-4ffe-9945-1026ed1771c5",
                "user_id": "f766bd60-f1df-474c-82e7-0cfda9d9879a"
              }
            }

+ Response 201

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttBPKrAktZQAAAWD
            location: /api/v1/tags/71a6427a-7305-4fb9-9142-78072aea1e8c
    + Body
    
            {
              "data": {
                "id": "71a6427a-7305-4fb9-9142-78072aea1e8c",
                "name": "fugiat",
                "repository_id": "ce3c543b-21ac-4ffe-9945-1026ed1771c5",
                "user_id": "f766bd60-f1df-474c-82e7-0cfda9d9879a"
              }
            }


+ Request Create Tag for an User when parameters are invalid
**POST**&nbsp;&nbsp;`/api/v1/users/352cd31b-f13b-477b-ba35-483d9d53ef53/tags`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "tag": {}
            }

+ Response 422

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttNjpkB0bekAAAKJ
    + Body
    
            {
              "errors": [
                "repository_id can't be blank",
                "name can't be blank"
              ]
            }
### GRTagWeb.Tags delete [DELETE /api/v1/tags/{id}]


+ Request Delete Tag
**DELETE**&nbsp;&nbsp;`/api/v1/tags/5d924bc9-92cf-40f1-8cb6-7d12eb4b1747`

    + Headers
    
            accept: application/json

+ Response 204

    + Headers
    
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ts32TmD1FHgAAAJC
    + Body
    
            


+ Request Delete Tag fails when tag does not exist
**DELETE**&nbsp;&nbsp;`/api/v1/tags/dfc88917-bd74-4d57-8b2a-cdec620d02d1`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttFMifgX_SwAAAYD
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }
### GRTagWeb.Tags index [GET /api/v1/tags]


+ Request List Tags
**GET**&nbsp;&nbsp;`/api/v1/tags`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttWFA4hqxlUAAAZD
    + Body
    
            {
              "data": [
                {
                  "id": "505a093d-b356-4390-aa3d-d440342af091",
                  "name": "illo",
                  "repository_id": "f6f70596-9f42-4ba7-9038-8df0ff4366de",
                  "user_id": "fa52e240-7abd-45ff-a3c8-38945727e5ff"
                },
                {
                  "id": "610ae6e2-3ae6-4dae-bbe0-9c045f8c460f",
                  "name": "qui",
                  "repository_id": "a60f0bac-b906-4348-ae33-ffd76d78a6d5",
                  "user_id": "8c9a3e45-772d-4d21-b4a1-5dbf1567b7a6"
                },
                {
                  "id": "f1911231-c16d-47b3-9e29-f96e861b1df3",
                  "name": "dignissimos",
                  "repository_id": "f00e6eca-6a02-466f-a957-3806fedddd3a",
                  "user_id": "7f47b2b8-62c2-4d0c-b151-020f7cc5b329"
                },
                {
                  "id": "30e138fe-4ae2-4014-8c98-4ecade6940fa",
                  "name": "dolores",
                  "repository_id": "be5ebd7e-a37a-4f31-a038-944b15d55321",
                  "user_id": "dca7b020-4af2-4f9a-88dd-a3db3b1948ad"
                },
                {
                  "id": "582b981f-5856-402d-a8c5-b79c734af2f2",
                  "name": "quis",
                  "repository_id": "db1e3359-bbe9-4a89-8145-17cfed5b560f",
                  "user_id": "a122bc17-f855-4f28-b7c1-27688261334c"
                }
              ]
            }
### GRTagWeb.Tags show [GET /api/v1/tags/{id}]


+ Request Fetch Tag
**GET**&nbsp;&nbsp;`/api/v1/tags/3d1308b3-5036-40ec-91fb-f1f0e1b2da5e`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2tszaoUhT4qwAAAIC
    + Body
    
            {
              "data": {
                "id": "3d1308b3-5036-40ec-91fb-f1f0e1b2da5e",
                "name": "molestias",
                "repository_id": "88b97bee-bb11-4c99-80ee-614a21aa825f",
                "user_id": "aae7db82-fac2-424f-bac2-d5bb6bb472ea"
              }
            }


+ Request Fetch Tag fails when Tag does not exist
**GET**&nbsp;&nbsp;`/api/v1/tags/dbfa99b7-ae54-4c7a-96a2-7d234211cabf`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttDtP3Ca0mAAAAXD
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }
### GRTagWeb.Tags update [PATCH /api/v1/tags/{id}]


+ Request Updating Tag
**PATCH**&nbsp;&nbsp;`/api/v1/tags/a3607471-9618-4f26-90dd-0a18005e7934`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "tag": {
                "name": "new_name"
              }
            }

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttKijKh-fa8AAAJJ
            location: /api/v1/tags/a3607471-9618-4f26-90dd-0a18005e7934
    + Body
    
            {
              "data": {
                "id": "a3607471-9618-4f26-90dd-0a18005e7934",
                "name": "new_name",
                "repository_id": "56a59a81-866f-4da3-aeba-c81437a5c321",
                "user_id": "345aa597-7ff9-4319-a007-c313a6b89a64"
              }
            }


+ Request Update Tag fails when tag does not exist
**PATCH**&nbsp;&nbsp;`/api/v1/tags/5ffb0cb7-168d-4a17-84f0-7f0f53cf3136`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "tag": {}
            }

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2tsrORui7r1UAAAVD
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }


+ Request Update Tag when parameters are invalid
**PATCH**&nbsp;&nbsp;`/api/v1/tags/1f672288-3326-4885-bc70-b3fe6e37f93e`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "tag": {
                "name": null
              }
            }

+ Response 422

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ts-KNNAukywAAAKC
    + Body
    
            {
              "errors": [
                "name can't be blank"
              ]
            }

# Group GRTagWeb.Users
## GRTagWeb.Users [/api/v1/users]
### GRTagWeb.Users create [POST /api/v1/users]


+ Request Create User
**POST**&nbsp;&nbsp;`/api/v1/users`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "user": {
                "username": "jailyn.leffler"
              }
            }

+ Response 201

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttXJioAssLUAAANB
            location: /api/v1/users/13a6f105-b27e-43d6-b6e0-ebfb797d249b
    + Body
    
            {
              "data": {
                "id": "13a6f105-b27e-43d6-b6e0-ebfb797d249b",
                "username": "jailyn.leffler"
              }
            }


+ Request Create User when parameters are invalid
**POST**&nbsp;&nbsp;`/api/v1/users`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "user": {}
            }

+ Response 422

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttbZVKBtJ3cAAALJ
    + Body
    
            {
              "errors": [
                "username can't be blank"
              ]
            }
### GRTagWeb.Users show [GET /api/v1/users/{id}]


+ Request Fetch User
**GET**&nbsp;&nbsp;`/api/v1/users/b662a9a8-fe8a-4036-ad25-7441212e097e`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttcCmwj5d1oAAALC
    + Body
    
            {
              "data": {
                "id": "b662a9a8-fe8a-4036-ad25-7441212e097e",
                "username": "katarina1965"
              }
            }


+ Request Fetch User fails when user does not exist
**GET**&nbsp;&nbsp;`/api/v1/users/ca560e8d-4a96-4494-9812-6d2cf8f869c2`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb2ttdDPejU3OoAAAbD
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }

