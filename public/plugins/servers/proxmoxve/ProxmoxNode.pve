<?php

namespace ProxmoxApi;


/**
 * Class ProxmoxNode
 * @package ProxmoxApi
 */
class ProxmoxNode
{
    use ProxmoxMethodsTrait;

    /**
     * @var ProxmoxClient
     */
    protected $client;

    /**
     * @var string
     */
    protected $name;

    /**
     * @var \stdClass
     */
    private $config;

    /**
     * ProxmoxNode constructor.
     * @param ProxmoxClient $client
     * @param string $name
     */
    public function __construct(ProxmoxClient $client, $name) {
        $this->client = $client;
        $this->name = $name;
    }

    /**
     * @param int $vmid
     * @return ProxmoxVM
     */
    public function vm($vmid) {
        return new ProxmoxVM($this, $vmid);
    }

    /**
     * @return ProxmoxClient
     */
    public function client() {
        return $this->client;
    }

    /**
     * @return string
     */
    public function path() {
        return "/nodes/{$this->name}";
    }

    /**
     * @return \stdClass
     * @throws ProxmoxApiException
     */
    public function config() {
        if(is_null($this->config)) {
            $this->config = $this->get('config');
        }
        return $this->config;
    }
}