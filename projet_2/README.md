## Projet 2

Nous allons créer une instance EC2 qui nous servira de base pour terraformer:

Pour se faire nous utiliserons tout de même terraform:
![Oeuf ou la poule](./chicken-or-the-egg.jpg)

    (avec des clés API AWS valides temporairement)

 L'objectif est de disposer d'une machine ayant un accès privilégié et sécurisé à des token AWS.

Cela est permis par l'utilisation d'un ["IAM Instance Profile" associé à un Rôle IAM](https://www.terraform.io/docs/providers/aws/index.html#ec2-role), terraform interrogera le endpoint `metadata API` pour obtenir des crédentials à la volé, pour une durée de vie limitée.

### Best practice:

Nous allons donner le minimum de droit à l'EC2 en lui associant une [policy minimum](https://gist.github.com/Oxalide-Team-2/9776c1995ced38805f98e8519911fa70):

Ces fichiers sont déjà présents à la racine de projet_2/terraform:

    iam-terraform-create-policy.tf
    iam-terraform-delete-policy.tf
    iam-terraform-read-policy.tf

### Question 1:

#### Setup d'une instance EC2 dédiée à terraform:

Allez dans:

    cd projet_2/terraform

Récupérer des clés AWS temporaire auprès du formateur.
```
export AWS_DEFAULT_REGION=eu-central-1
export AWS_ACCESS_KEY_ID=xxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxx
export AWS_SESSION_TOKEN=xxxxxxxxxxxxxxxxxxxxxx
```

Chaque étudiant doit modifier le projet afin de créer une instance ec2 unique:

- Comment modifier la valeur du tag Trigramme présent dans [projet_2/terraform/ec2.tf](https://github.com/Oxalide-Team-2/terraform-formation/blob/master/projet_2/terraform/ec2.tf#L24), sans modifier un fichier .tf ?

Plusieurs solutions, la déclaration de variable d'envrionnement préfixée `TF_VAR_` permet de les passer à terraform.

`export TF_VAR_student=jbo` (autre solution: passage par -var)

Ces variables seront visibles dans le contexte terraform comme ceci : `${var.student}`

- Dans ec2.tf, remplacer la public_key par votre clé pub.

```
terraform init
terraform plan
# Analysez le résultat du plan

terraform apply
```

L'instance est initialisée avec une EIP, connectez-vous:

```
ssh admin@$(terraform output eip)
```

- Vérifiez la présence des outils `unzip wget vim locate curl`
- Comment ces outils ont-il été installés ?

### Support or Contact

Julien BOULANGER jbo@oxalide.com
