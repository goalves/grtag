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
            x-request-id: Ffb4BBHFBDBxNeEAAAaE
    + Body
    
            {
              "data": [
                {
                  "description": "Voluptatem alias veniam commodi labore eos sint! Quos eius porro ut ipsum eveniet architecto tenetur quos quis? Asperiores sit fuga et minus quia earum labore aliquid? Id facere at nobis iure quo sapiente. Ut nisi eos repellat consectetur quas illum molestiae sit!",
                  "github_id": 723040205,
                  "id": "d39c80e7-3139-4d2b-aebe-6632a97b76b1",
                  "language": "voluptates",
                  "name": "voluptate",
                  "url": "http://oconnell.biz"
                },
                {
                  "description": "Voluptas natus harum non tempore accusamus et. Doloremque doloribus voluptatum ut. Totam quisquam voluptatem qui fugiat voluptatem enim.",
                  "github_id": 945816364,
                  "id": "fb3b5fc6-c3e3-4b26-bbce-e92438302848",
                  "language": "modi",
                  "name": "culpa",
                  "url": "http://schroeder.name"
                },
                {
                  "description": "Earum hic doloremque in! Consequatur fuga officia consectetur ullam laudantium. Ut est nesciunt voluptas neque odit sed quae. Assumenda deserunt sit explicabo qui nisi ipsa.",
                  "github_id": 501490714,
                  "id": "4eeedd54-7c86-44f7-93de-a5032f96909c",
                  "language": "esse",
                  "name": "ad",
                  "url": "http://bergstrom.info"
                },
                {
                  "description": "Molestias omnis qui sint repellat ipsa ea asperiores repudiandae et? Et perspiciatis sapiente quo molestiae? Et nostrum consequuntur odit in voluptas molestiae quibusdam?",
                  "github_id": 311326755,
                  "id": "b5f4e2cf-66ec-497d-835a-51430370986b",
                  "language": "quam",
                  "name": "ut",
                  "url": "http://kessler.net"
                },
                {
                  "description": "Ea et et et tempore mollitia expedita. Veniam aperiam aut quidem ratione velit dignissimos eos sapiente iure. Et non cum praesentium?",
                  "github_id": 597447525,
                  "id": "2807d029-f0a9-434e-afc5-7ff94b73a37e",
                  "language": "esse",
                  "name": "tempora",
                  "url": "https://kub.net"
                }
              ]
            }
### GRTagWeb.Repositories show [GET /api/v1/repositories/{id}]


+ Request Fetch Repository
**GET**&nbsp;&nbsp;`/api/v1/repositories/db9cd16f-2b86-491f-b397-43f8779dc888`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4BBEGuViPpEsAAAjI
    + Body
    
            {
              "data": {
                "description": "Sapiente natus officiis et et omnis tempora. Unde facere vitae repellendus officiis dolorem aut assumenda quia? Quos eligendi maxime maxime. Hic aut quia in temporibus.",
                "github_id": 443584618,
                "id": "db9cd16f-2b86-491f-b397-43f8779dc888",
                "language": "repudiandae",
                "name": "nobis",
                "url": "http://ernser.net"
              }
            }


+ Request Fetch Repository fails when repository does not exist
**GET**&nbsp;&nbsp;`/api/v1/repositories/771c76cc-45fe-4838-a9a6-23355f262710`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4BBCclXiSzrAAAAZE
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }

# Group GRTagWeb.Tags
## GRTagWeb.Tags [/api/v1/users/6b908d87-763f-4dee-a122-384d5cd201b6/tags]
### GRTagWeb.Tags create [POST /api/v1/users/3248f4c5-aa75-485f-8fe2-6bfeb40adf37/{id}]


+ Request Create Tag for an User
**POST**&nbsp;&nbsp;`/api/v1/users/6b908d87-763f-4dee-a122-384d5cd201b6/tags`

    + Headers
    
            accept: application/json
            content-type: multipart/mixed; boundary=plug_conn_test
    + Body
    
            {
              "tag": {
                "name": "corrupti",
                "repository_id": "e51ab8b9-e532-426f-8947-517a87c366f6",
                "user_id": "6b908d87-763f-4dee-a122-384d5cd201b6"
              }
            }

+ Response 201

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A83kVoB4hbQAAAVE
            location: /api/v1/tags/3cd447ef-819c-4552-83f4-cdbb6fbe8ce7
    + Body
    
            {
              "data": {
                "id": "3cd447ef-819c-4552-83f4-cdbb6fbe8ce7",
                "name": "corrupti",
                "repository_id": "e51ab8b9-e532-426f-8947-517a87c366f6",
                "user_id": "6b908d87-763f-4dee-a122-384d5cd201b6"
              }
            }


+ Request Create Tag for an User when parameters are invalid
**POST**&nbsp;&nbsp;`/api/v1/users/3248f4c5-aa75-485f-8fe2-6bfeb40adf37/tags`

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
            x-request-id: Ffb4A9gzd7DdrosAAAbI
    + Body
    
            {
              "errors": [
                "repository_id can't be blank",
                "name can't be blank"
              ]
            }
### GRTagWeb.Tags delete [DELETE /api/v1/tags/{id}]


+ Request Delete Tag
**DELETE**&nbsp;&nbsp;`/api/v1/tags/e4b78ee3-051e-45e5-97e8-e3bce5de0382`

    + Headers
    
            accept: application/json

+ Response 204

    + Headers
    
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A9dpEzBCRGsAAAaI
    + Body
    
            


+ Request Delete Tag fails when tag does not exist
**DELETE**&nbsp;&nbsp;`/api/v1/tags/0d01f385-2058-42c9-90fb-3c1d297e9682`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A9AUw0BW-vkAAAUI
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
            x-request-id: Ffb4A9ZP0zBA0UMAAAYI
    + Body
    
            {
              "data": [
                {
                  "id": "c192b975-467c-4738-9784-6e1aea8a03dc",
                  "name": "voluptatem",
                  "repository_id": "65b7da89-d429-44de-ba54-34fdaced50cc",
                  "user_id": "8c56b668-441e-41db-a3b3-c857376dc9e4"
                },
                {
                  "id": "f3df23ea-0614-45bf-8a91-b83de8687f62",
                  "name": "voluptatum",
                  "repository_id": "23d740b2-84e6-490a-bcfc-f4675d1f6f26",
                  "user_id": "52d943aa-5714-482a-abc5-334582a1fd6c"
                },
                {
                  "id": "223a80bb-c4b0-4f40-82e0-032636c9e2ac",
                  "name": "explicabo",
                  "repository_id": "51d23e31-b72a-4b8f-b7d2-763d9a151bc4",
                  "user_id": "626c046d-dd49-4f90-9aa1-35c82b799abd"
                },
                {
                  "id": "ec9e1f49-2b47-4b9f-9d29-5478ceb8b46a",
                  "name": "sit",
                  "repository_id": "83e6b6cf-fcc9-4596-935a-533748ec31b2",
                  "user_id": "54cdc8cd-3b8e-4f45-ae36-f1fb6f1a8ff3"
                },
                {
                  "id": "14359eb2-8262-4ecc-87dc-20c2d126967a",
                  "name": "sit",
                  "repository_id": "4c92cdd0-5b47-4518-bafe-71aa8345ae8a",
                  "user_id": "e03f0c8b-a194-4f73-9b60-f2094d7a8e1e"
                }
              ]
            }
### GRTagWeb.Tags show [GET /api/v1/tags/{id}]


+ Request Fetch Tag
**GET**&nbsp;&nbsp;`/api/v1/tags/519a0ffe-45cc-4259-8cb5-25f7379c76d4`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A9GK2OAzo68AAAVI
    + Body
    
            {
              "data": {
                "id": "519a0ffe-45cc-4259-8cb5-25f7379c76d4",
                "name": "doloribus",
                "repository_id": "74a90e37-f45e-4191-a751-2649d9165b75",
                "user_id": "3c931a5d-e087-400d-b90e-b730f3a15d6a"
              }
            }


+ Request Fetch Tag fails when Tag does not exist
**GET**&nbsp;&nbsp;`/api/v1/tags/7e67daf8-da1f-4b0b-8e2d-2822a87c92e1`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A9aJdRj9eEQAAAYE
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }
### GRTagWeb.Tags update [PATCH /api/v1/tags/{id}]


+ Request Updating Tag
**PATCH**&nbsp;&nbsp;`/api/v1/tags/102e16ea-0e36-44a0-b16f-722c3b40117e`

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
            x-request-id: Ffb4A9Jf76jeCJkAAAWI
            location: /api/v1/tags/102e16ea-0e36-44a0-b16f-722c3b40117e
    + Body
    
            {
              "data": {
                "id": "102e16ea-0e36-44a0-b16f-722c3b40117e",
                "name": "new_name",
                "repository_id": "8e07c14d-f4df-48b5-9ea0-b40f0f2ac5f6",
                "user_id": "d354ae88-53b7-49c3-8f40-17293042a175"
              }
            }


+ Request Update Tag fails when tag does not exist
**PATCH**&nbsp;&nbsp;`/api/v1/tags/1ba7c3ef-b7c9-4cc5-bac3-751c97950040`

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
            x-request-id: Ffb4A9QSTuBgKm4AAAXI
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }


+ Request Update Tag when parameters are invalid
**PATCH**&nbsp;&nbsp;`/api/v1/tags/4ba6ab0c-2f4d-4061-accd-1b8688fd7622`

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
            x-request-id: Ffb4A9OwJfjKGfsAAAXE
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
                "username": "ralph_barrows"
              }
            }

+ Response 201

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A_30I_DbZb0AAAhI
            location: /api/v1/users/b2328656-7349-46d1-853b-947695e328b8
    + Body
    
            {
              "data": {
                "id": "b2328656-7349-46d1-853b-947695e328b8",
                "username": "ralph_barrows"
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
            x-request-id: Ffb4A_-y9qgmr1IAAAIB
    + Body
    
            {
              "errors": [
                "username can't be blank"
              ]
            }
### GRTagWeb.Users show [GET /api/v1/users/{id}]


+ Request Fetch User
**GET**&nbsp;&nbsp;`/api/v1/users/93616b3d-83e9-4db3-b1ff-5d34da76991e`

    + Headers
    
            accept: application/json

+ Response 200

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A_2YBehaSXIAAAfI
    + Body
    
            {
              "data": {
                "id": "93616b3d-83e9-4db3-b1ff-5d34da76991e",
                "username": "ruben_barton"
              }
            }


+ Request Fetch User fails when user does not exist
**GET**&nbsp;&nbsp;`/api/v1/users/021307f4-fda5-48cd-8f04-953e98812641`

    + Headers
    
            accept: application/json

+ Response 404

    + Headers
    
            content-type: application/json; charset=utf-8
            cache-control: max-age=0, private, must-revalidate
            x-request-id: Ffb4A_9nvNhHxBgAAAHB
    + Body
    
            {
              "errors": {
                "detail": "Not Found"
              }
            }

