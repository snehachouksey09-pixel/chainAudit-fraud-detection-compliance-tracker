// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ChainAudit
 * @dev A decentralized audit logging system for blockchain-based project tracking.
 *      Allows registered users to submit audit logs and verify integrity transparently.
 */
contract ChainAudit {
    // Struct for each audit record
    struct AuditRecord {
        uint256 id;
        address auditor;
        string projectName;
        string description;
        uint256 timestamp;
    }

    // State variables
    mapping(uint256 => AuditRecord)  public auditLogs;
    uint256 public auditCount;
    address public owner;

    // Events
    event AuditSubmitted(uint256 indexed id, address indexed auditor, string projectName, uint256 timestamp);
    event AuditDeleted(uint256 indexed id, address indexed by);

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized: Owner only");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Submit a new audit log.
     * @param _projectName Name of the audited project.
     * @param _description Description or summary of the audit.
     */
    function submitAudit(string memory _projectName, string memory _description) external {
        auditCount++;
        auditLogs[auditCount] = AuditRecord(auditCount, msg.sender, _projectName, _description, block.timestamp);
        emit AuditSubmitted(auditCount, msg.sender, _projectName, block.timestamp);
    }

    /**
     * @notice Retrieve an audit record by ID.
     * @param _id The unique ID of the audit record.
     * @return AuditRecord struct containing audit details.
     */
    function getAudit(uint256 _id) external view returns (AuditRecord memory) {
        require(_id > 0 && _id <= auditCount, "Invalid audit ID");
        return auditLogs[_id];
    }

    /**
     * @notice Delete an audit record (Owner only).
     * @param _id The ID of the audit record to remove.
     */
    function deleteAudit(uint256 _id) external onlyOwner {
        require(_id > 0 && _id <= auditCount, "Invalid audit ID");
        delete auditLogs[_id];
        emit AuditDeleted(_id, msg.sender);
    }
}
