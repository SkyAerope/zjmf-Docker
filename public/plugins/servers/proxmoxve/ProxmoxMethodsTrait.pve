<?php

namespace ProxmoxApi;


/**
 * Trait ProxmoxApiTrait
 * @package ProxmoxApi
 */
trait ProxmoxMethodsTrait
{
    /**
     * @return ProxmoxClient
     */
    abstract function client();

    /**
     * @return string
     */
    abstract function path();

    /**
     * @param string $action
     * @param array $params
     * @return mixed
     * @throws ProxmoxApiException
     */
    public function get($action, array $params = []) {
        return $this->client()->request(ProxmoxClient::REQUEST_MENTHOD_GET, $this->pathNormalize($action), $params);
    }

    /**
     * @param string $action
     * @param array $params
     * @return mixed
     * @throws ProxmoxApiException
     */
    public function create($action, array $params = []) {
        return $this->client()->request(ProxmoxClient::REQUEST_MENTHOD_POST, $this->pathNormalize($action), $params);
    }

    /**
     * @param string $action
     * @param array $params
     * @return mixed
     * @throws ProxmoxApiException
     */
    public function set($action, array $params = []) {
        return $this->client()->request(ProxmoxClient::REQUEST_MENTHOD_PUT, $this->pathNormalize($action), $params);
    }

    /**
     * @param string $action
     * @return mixed
     * @throws ProxmoxApiException
     */
    public function delete($action) {
        return $this->client()->request(ProxmoxClient::REQUEST_MENTHOD_DELETE, $this->pathNormalize($action));
    }

    private function pathNormalize($action) {
        return rtrim($this->path(), '/') . '/' . ltrim($action, '/');
    }
}