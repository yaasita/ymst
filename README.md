# Yaml Mailing liST

## これは何？

yamlで管理するメーリングリスト

yaml例

    mltest1@ml.example.com:
      - member1@example.com
      - member2@example.com
      - member3@example.com
    mltest2@ml.example.com:
      - member4@example.com
      - member5@example.com
      - member6@example.com

この場合,`mltest1@ml.example.com`に送れば
以下アドレスに送られます

- member1@example.com
- member2@example.com
- member3@example.com

## インストール

### 準備

- サーバを用意しログインできるようにしておく(ubuntu14.04で動作確認済)
- MXレコードを設定しておく
- [ansible](http://www.ansible.com/)をインストールしておく

### 設定ファイル

1. `ansible/roles/ymst/files/authorized_keys`
    自分の公開鍵を登録する

        wget --no-check-certificate https://github.com/yourname.keys -O - >> ansible/roles/ymst/files/authorized_keys
2. `ansible/ansible_hosts`
ログインできるホスト名、ユーザ名、sudoパスワード等設定する

        yourserver.eample.com ansible_ssh_user='yourname' ansible_sudo_pass='yourpasswd'
3. `ansible/group_vars/all`
サーバのドメインに変更する

        # メールサーバのドメイン
        ml_domain: yourserver.example.com
4. ansible実行

        cd ansible
        ansible-playbook site.yml

### 設定変更

deployしたサーバのgitリポジトリに直接pushして反映

    git clone ymst@yourserver.eample.com:ymst
    cd ymst
    vi mail.yml
    git add mail.yml && git commit -m "mod ml" && git push

## 仕組み

    mail => postfix => bin/ymst.sh => bin/send.rb => sendmail
