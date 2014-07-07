- job:
    name: 'upgrade'
    description: 'Upgrade Spinal Stack'
    project-type: freestyle
    wrappers:
      - ansicolor:
          colormap: xterm
    builders:
      - shell: |
          set +e
          sudo -i ansible-playbook -s -M /srv/edeploy/ansible/library /etc/ansible/site.yml -v --tags "before_config"
          echo '1' | sudo tee /etc/config-tools/step
          sudo configure.sh
          sudo -i ansible-playbook -s -M /srv/edeploy/ansible/library /etc/ansible/site.yml -v --tags "after_config"
          ret=$?
          exit $ret
