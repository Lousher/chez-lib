

(define AZURE_CURRENT_PROJECT_NAME "")


(define x-generate (lambda () 0.0))
(define y-generate
  (let ([y 0.0])
    (lambda ()
      (set! y (- y 200))
      y)))

(define azure-archive-current-project
  (lambda ()
    AZURE_CURRENT_PROJECT_NAME))

(define guid-generate
  (lambda ()
    (get-line
     (car (process "uuidgen | tr 'A-F' 'a-f'")))))

(define azure-archive-project-init
  (lambda (project-name title header)
    (set! AZURE_CURRENT_PROJECT_NAME project-name)
    (let ([template (call-with-input-file
			(format "~a/~a" AZURE_ARCHIVE_PROJECT_TEMPLATE_DIRECTORY "init.json")
		      get-string-all)])
      (call-with-output-file
	  (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY project-name)
	(lambda (out)
	  (format out template project-name header title title header))))))

(define save-node-file
  (lambda (type . args)
    (call-with-output-file
	(format "~a/temp.node" AZURE_ARCHIVE_PROJECTS_DIRECTORY)
      (lambda (port)
	(let ([template (call-with-input-file
			    (format "~a/~anode.json" AZURE_ARCHIVE_PROJECT_TEMPLATE_DIRECTORY (symbol->string type))
			  get-string-all)])
	  (apply format port template args))))))

(define save-data-file
  (lambda (type . args)
    (call-with-output-file
	(format "~a/temp.data" AZURE_ARCHIVE_PROJECTS_DIRECTORY)
      (lambda (port)
	(let ([template (call-with-input-file
			    (format "~a/~adata.json" AZURE_ARCHIVE_PROJECT_TEMPLATE_DIRECTORY (symbol->string type))
			  get-string-all)])
	  (apply format port template args))))))

(define delete-node-file
  (lambda ()
    (delete-file (format "~a/temp.node" AZURE_ARCHIVE_PROJECTS_DIRECTORY))))

(define delete-data-file
  (lambda ()
    (delete-file (format "~a/temp.data" AZURE_ARCHIVE_PROJECTS_DIRECTORY))))

(define insert-script-node
  (lambda (name)
    (let ([id (guid-generate)])
      (save-node-file 'script name id (x-generate) (y-generate))
      (system (format "cd ~a && jq '.nodes[\"$values\"] += [input]' ~a.aap temp.node > ~a.aap.back" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME AZURE_CURRENT_PROJECT_NAME))
      (delete-file (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME))
      (rename-file
       (format "~a/~a.aap.back" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME)
       (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME))
      (delete-node-file)
      id)))
 
(define insert-selection-node
  (lambda ()
    (let ([id (guid-generate)])
      (save-node-file 'selection id (x-generate) (y-generate))
      (system (format "cd ~a && jq '.nodes[\"$values\"] += [input]' ~a.aap temp.node > ~a.aap.back" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME AZURE_CURRENT_PROJECT_NAME))
      (delete-file (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME))
      (rename-file
       (format "~a/~a.aap.back" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME)
       (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME))
      (delete-node-file)
      id)))

(define insert-script-data
  (lambda (script-node-guid)
    (let ([id (guid-generate)])
      (save-data-file 'script id)
      (system (format "cd ~a && jq '(.nodes.\"$values\"[] | select(.Guid == \"~a\").Scripts.\"$values\") += [input]' ~a.aap temp.data > ~a.aap.back" AZURE_ARCHIVE_PROJECTS_DIRECTORY script-node-guid AZURE_CURRENT_PROJECT_NAME AZURE_CURRENT_PROJECT_NAME))
      (delete-file (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME))
      (rename-file
       (format "~a/~a.aap.back" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME)
       (format "~a/~a.aap" AZURE_ARCHIVE_PROJECTS_DIRECTORY AZURE_CURRENT_PROJECT_NAME))
      (delete-data-file)
      id)))

(define character-begin-pos
  (lambda (script-id voice-id name pos)
    (system
     (format "cd ~a && jq '(.nodes.\"$values\"[] | select(.Guid == \"~a\").Scripts.\"$values\") += [input]' ~a.aap temp.data > ~a.aap.back"
	     AZURE_ARCHIVE_PROJECTS_DIRECTORY
	     
    
;;jq '(.nodes."$values"[]| select(.Guid == "accf8473-170b-4978-9b0a-1eb42631d8dc") | .Scripts."$values"[] | select(.voice == "de5d8d5f-0aa1-49a0-957c-4741f26888e5")).characters."$values"[3].name |= "HAHAHA"' TestP.aap

   
