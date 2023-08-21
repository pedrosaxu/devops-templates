> 🚨 Fala pessoal, tudo bom? Publicando o material da palestra aqui pra vocês já terem acesso, mas este é literalmente o código que foi construído durante o longo dessa jornada, e tem muito espaço pra melhoria de código, então fiquem a vontade para contribuir com o projeto, e se tiverem alguma dúvida, só me chamar no [Linkedin](https://www.linkedin.com/in/pedrosaxu/) que eu respondo assim que possível.

## 📚 Sobre o projeto

Projeto apresentado no DevOpsDays Rio 2023, [ppt disponível aqui](/TerraformAtScale/ppt_terraformatscale.pdf).


### Pipeline de criação de projetos e ambientes Terraform
Este pipeline automatiza a criação de projetos e e ambientes Terraform no Azure DevOps e no Terraform Cloud. Ele é composto por três etapas principais:

1. **Verificar se o projeto e/ou repositório já existem no Azure Devops:** esta etapa cria um novo projeto no Azure DevOps para o cliente especificado. Se o projeto já existir, a etapa informará o usuário e passará para a próxima etapa.

2. **Criar os projetos no Azure Devops e no Terraform Cloud:** esta etapa cria um novo projeto no Terraform Cloud e no Azure Devops para o cliente e projeto especificados. Se o projeto já existir, a etapa informará o usuário e passará para a próxima etapa.

3. **Criar o repositório no Azure Devops e o Workspace no Terraform Cloud:** esta etapa cria um novo repositório no Azure Devops e workspace do Terraform Cloud para o cliente e projeto especificados. Se o ambiente já existir, a etapa informará o usuário.

4. **Criar as novas pastas no repositório e os workspace do Terraform Cloud dos ambientes do projeto:** esta etapa cria os ambientes do projeto nas ferramentas. Se os ambientes já existirem, a etapa informará o usuário. 

### Como usar
Para usar este pipeline, siga estas etapas:

1. Crie uma organização no Azure Devops e no Terraform Cloud e preencha os valores ao longo do pipeline e dos terraforms (Isso dá pra melhorar no código).
2. Suba o código desse repo no teu Azure Repos já com as novas variáveis.
3. Crie um novo pipeline no Azure DevOps.
4. Selecione o novo repositório como a fonte do pipeline.
5. Gere os seguintes tokens que serão necessários para a execução do pipeline:
   - Um token de acesso pessoal (PAT) do Azure DevOps com acesso admin na organização.
   - Um token de API do Terraform Cloud com acesso admin na organização.
   - Um token OAuth do Azure DevOps para o Terraform Cloud.
6. Configure as variáveis de pipeline necessárias, incluindo *ado_organization_pat*, *tfe_token_api* e *ado_tfe_oauth_token*.
7. Execute o pipeline.

### Variáveis e Parameters do pipeline
Este pipeline requer as seguintes variáveis de pipeline:

- *ado_organization_pat:* o token de acesso pessoal (PAT) da organização do Azure DevOps.
  > Crie uma variável do tipo segura no pipeline, e desmarque a opção "Permitir que o usuário defina o valor desta variável em tempo de execução".
- *tfe_token_api:* o token de API do Terraform Cloud.
  > Crie uma variável do tipo segura no pipeline, e desmarque a opção "Permitir que o usuário defina o valor desta variável em tempo de execução".
- *ado_tfe_oauth_token:* o token OAuth do Azure DevOps para o Terraform Cloud.
  > Crie uma variável do tipo segura no pipeline, e desmarque a opção "Permitir que o usuário defina o valor desta variável em tempo de execução".
- *parameters.client:* o nome do cliente para o qual o projeto e ambiente serão criados.
  > Não incluir espaços nem hífens, o único caractere especial permitido é o underline.
- *parameters.project:* o nome do projeto para o qual o ambiente será criado.
  > Não incluir espaços nem hífens, o único caractere especial permitido é o underline.
- *parameters.envs:* uma **lista** de ambientes separados por vírgulas que serão criados no repositório e workspace do Terraform Cloud.
  > Respeitar a formatação de lista: `["dev", "prod"]`

### Contribuindo
Se você quiser contribuir para este pipeline, sinta-se à vontade para enviar um pull request.

