# Revora: demo de peças de acabamento descontinuadas (piloto IE / RHD)

Banco SQLite pequeno + uma página de consulta que funciona offline. Feito para mostrar o conceito na Auto Trade EXPO (Dublin, 10-11 out 2026).

A ideia do piloto: peças simples, cujas **dimensões já estão publicadas**, para modelar sem precisar escanear.

## Arquivos

| Arquivo | O que é |
|---|---|
| `index.html` | A página de consulta. Um arquivo só, sem internet. Abre no celular/tablet. |
| `pecas_ie.db` | O banco SQLite (abre no DBeaver). |
| `schema.sql` | Tabelas. Mesmo desenho do schema original, com `supply_status` em `parts` e o nível de confiança `aftermarket_catalogue`. |
| `seed.sql` | Os dados do piloto: 4 modelos, 10 peças, com a fonte de cada dimensão e de cada compatibilidade. |
| `template.html` | Molde da página. `build.py` injeta os dados do banco nele. |
| `build.py` | Recria o `.db` e o `index.html`. Só biblioteca padrão do Python. |

## Na feira

1. Copie `index.html` para o tablet/celular e abra pelo navegador (funciona em modo avião).
2. Teste hoje à noite no aparelho que vai levar. Os testes que fiz foram automatizados, não em um tablet real.
3. Use a página como gancho para o roteiro: "você já procurou algum desses clipes e não achou?".

## Regenerar depois de mudar os dados

```bash
python3 build.py
```

Para adicionar uma peça: edite `seed.sql` (`parts`, `part_vehicle_compatibility`, `sources` e `part_dimensions`) e rode o build. A página mostra as medidas de `part_dimensions` automaticamente.

## Abrir no DBeaver

New Database Connection > SQLite > Path: `pecas_ie.db`.

## Publicar uma versão online (opcional)

Como o repositório é público, dá para servir o `index.html` pelo GitHub Pages: Settings > Pages > Source: "Deploy from a branch" > branch `main`, pasta `/ (root)`. O endereço fica `https://bentjul-eng.github.io/revora-automotive-eng/` depois de alguns minutos. Serve para o QR code, mas na feira use a cópia local, porque o wifi pode falhar.

## De onde vêm os dados

- **Dimensões**: catálogos de fornecedores (Lawson, Kimball Midwest, Kent Automotive), que trazem tabelas completas por número OEM; anúncios do eBay/Walmart, que são aproximados; e um post de fórum de dono de Avensis. Cada medida guarda a fonte e o tipo (`seller_listing_approx`, `supplier_catalogue`, `forum_post`).
- **Compatibilidade**: `aftermarket_catalogue` quando um catálogo de peças cita o modelo; `community_reported` quando um anúncio ou fórum cita; `inferred` quando só se deduz.
- **Atenção**: Lawson, Kimball e Kent são catálogos **dos EUA** e citam anos-modelo americanos. O carro vendido na Irlanda (RHD) pode usar outro clipe. Nenhuma compatibilidade foi verificada em carro irlandês.
- `supply_status` está em `unverified` para todas. Todas ainda aparecem à venda como reposição, então a descontinuação é uma hipótese a testar.
- Arquivos 3D: nenhum foi feito ainda.
- `design_right_status` está `unknown` em todas. É uma questão jurídica, não deve ser preenchida sem revisão.
- O Yaris está no demo pelos dados, mas não verifiquei o volume dele na frota irlandesa. Corolla, Avensis e Focus foram campeões de venda na Irlanda em 2005-2009.

## Candidatas deixadas de fora

Sem dimensões publicadas, ou de forma complexa demais. Só entram se houver CAD ou scan:

- Focus Mk2: `4M51-16613-AC`, `4M51-A24049-ACW`, `4M51-22642-ADW`, `3M51-226A37`
- Corolla E120/E150: `87945-05901`, `87915-05901` (capas de retrovisor), `90467-10167`, `90467-06049-22`

Sem compatibilidade confirmada com nenhum dos modelos: `90467-07211` (clipe de grade, só a cabeça tem medida).
